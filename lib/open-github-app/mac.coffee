shell = require 'shell'
path  = require 'path'

module.exports = (projectPath) ->
  shell.openExternal "github-mac://openRepo/#{path.resolve(projectPath)}"
