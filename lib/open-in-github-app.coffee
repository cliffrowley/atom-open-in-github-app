exec = require("child_process").exec

module.exports =
  activate: (state) ->
    atom.workspaceView.command "open-in-github-app:open", => @openApp()

  openApp: ->
    path = atom.project?.getPath()
    exec "open -a GitHub.app #{path}" if path?
