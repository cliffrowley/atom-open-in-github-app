shell       = require 'shell'
querystring = require 'querystring'

openAppForDirectory = (projectPath) ->
  protocol = switch process.platform
    when 'darwin' then 'github-mac'
    when 'win32'  then 'github-windows'

  shell.openExternal "#{protocol}://openRepo/#{querystring.escape(projectPath)}"

module.exports = openAppForDirectory
