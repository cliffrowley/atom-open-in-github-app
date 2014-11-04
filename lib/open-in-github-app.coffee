exec = require("child_process").exec
shell = require('shell')
repo = {}

module.exports =
  activate: (state) ->
    atom.workspaceView.command "open-in-github-app:open", => @openApp()

  openApp: ->
    path = atom.project?.getPath()
    repo = atom.project.getRepo()

    if process.platform is 'darwin'
      exec "open -a GitHub.app #{path}" if path?
    else
      if repo?
        url = @githubRepoUrl()
        shell.openExternal "github-windows://openRepo/#{url}"

  # From https://github.com/atom/open-on-github/blob/50b38b91acb0eb5e123dad49ba8ad3a82906ca5c/lib/github-file.coffee:

  # Internal
  githubRepoUrl: ->
    url = @gitUrl()
    if url.match /https:\/\/[^\/]+\// # e.g., https://github.com/foo/bar.git
      url = url.replace(/\.git$/, '')
    else if url.match /git@[^:]+:/    # e.g., git@github.com:foo/bar.git
      url = url.replace /^git@([^:]+):(.+)$/, (match, host, repoPath) ->
        repoPath = repoPath.replace(/^\/+/, '') # replace leading slashes
        "http://#{host}/#{repoPath}".replace(/\.git$/, '')
    else if url.match /^git:\/\/[^\/]+\// # e.g., git://github.com/foo/bar.git
      url = "http#{url.substring(3).replace(/\.git$/, '')}"

    url = url.replace(/\/+$/, '')

    return url # unless @isBitbucketUrl(url)

  # Internal
  gitUrl: ->
    remoteOrBestGuess = @remoteName() ? 'origin'
    repo.getConfigValue("remote.#{remoteOrBestGuess}.url", @filePath)

  # Internal
  remoteName: ->
    shortBranch = repo.getShortHead(@filePath)
    return null unless shortBranch

    branchRemote = repo.getConfigValue("branch.#{shortBranch}.remote", @filePath)
    return null unless branchRemote?.length > 0

    branchRemote
