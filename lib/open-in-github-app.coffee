{CompositeDisposable} = require 'atom'

ProjectPathListView = require './project-path-list-view'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'open-in-github-app:open', => @openApp()

  deactivate: ->
    @subscriptions.destroy()

  openApp: ->
    projectPaths = atom.project?.getPaths()

    if projectPaths.length is 0
      atom.notifications.addInfo 'Open in GitHub App',
        detail:      'This project has no folders!',
        dismissable: true
    else if projectPaths.length is 1
      require('./open-github-app')(projectPaths[0])
    else
      new ProjectPathListView(projectPaths)
