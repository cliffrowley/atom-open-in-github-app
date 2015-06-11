shell       = require 'shell'
giturlparse = require 'giturlparse'

{Directory} = require 'atom'

module.exports = (path) ->
  atom.project.repositoryForDirectory(new Directory(@projectPath)).then (repo) ->
    url = giturlparse(repo.getOriginURL()).toString('https')
    shell.openExternal "github-windows://openRepo/#{url}"
