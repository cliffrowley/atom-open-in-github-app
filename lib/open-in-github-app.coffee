exec = require("child_process").exec
shell = require('shell')

module.exports =
  activate: (state) ->
    atom.workspaceView.command "open-in-github-app:open", => @openApp()

  openApp: ->
    @filePath = atom.project?.getPath()
    repo = atom.project.getRepo()

    if process.platform is 'darwin'
      exec "open -a GitHub.app #{path}" if path?
    else
      if repo?
        url = @githubRepoUrl(repo)
        protocol = "github-windows://openRepo/#{url}"

        branch = @branchName(repo)
        protocol = protocol + "?branch=#{branch}" if branch?
        shell.openExternal protocol

  # Based on https://github.com/atom/open-on-github/blob/50b38b91acb0eb5e123dad49ba8ad3a82906ca5c/lib/github-file.coffee:

  githubRepoUrl: (repo) ->
    url = @gitUrl(repo)
    if url.match /https:\/\/[^\/]+\// # e.g., https://github.com/foo/bar.git
      url = url.replace(/\.git$/, '')
    else if url.match /git@[^:]+:/    # e.g., git@github.com:foo/bar.git
      url = url.replace /^git@([^:]+):(.+)$/, (match, host, repoPath) ->
        repoPath = repoPath.replace(/^\/+/, '') # replace leading slashes
        "http://#{host}/#{repoPath}".replace(/\.git$/, '')
    else if url.match /^git:\/\/[^\/]+\// # e.g., git://github.com/foo/bar.git
      url = "http#{url.substring(3).replace(/\.git$/, '')}"

    url = url.replace(/\/+$/, '')

    return url unless @isBitbucketUrl(url)

  gitUrl: (repo) ->
    remoteOrBestGuess = @remoteName(repo) ? 'origin'
    repo.getConfigValue("remote.#{remoteOrBestGuess}.url", @filePath)

  remoteName: (repo) ->
    shortBranch = repo.getShortHead(@filePath)
    return null unless shortBranch

    branchRemote = repo.getConfigValue("branch.#{shortBranch}.remote", @filePath)
    return null unless branchRemote?.length > 0

    branchRemote

  isBitbucketUrl: (url) ->
    return true if url.indexOf('git@bitbucket.org') is 0

    try
      {host} = parseUrl(url)
      host is 'bitbucket.org'

  branchName: (repo) ->
    shortBranch = repo.getShortHead(@filePath)
    return null unless shortBranch

    branchMerge = repo.getConfigValue("branch.#{shortBranch}.merge", @filePath)
    return shortBranch unless branchMerge?.length > 11
    return shortBranch unless branchMerge.indexOf('refs/heads/') is 0

    branchMerge.substring(11)
