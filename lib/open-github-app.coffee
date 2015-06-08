shell       = require 'shell'
querystring = require 'querystring'
path        = require 'path'

{Directory} = require 'atom'

openAppForDirectory = (projectPath) ->
  switch process.platform
    when 'darwin'
      shell.openExternal "github-mac://openRepo/#{path.resolve(projectPath)}"
    when 'win32'
    atom.project.repositoryForDirectory(new Directory(projectPath)).then (repo) ->
      shell.openExternal "#{protocol}://openRepo/#{repo.getOriginURL()}"

module.exports = openAppForDirectory
