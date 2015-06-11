{$$, SelectListView} = require 'atom-space-pen-views'

module.exports =
  class ProjectPathListView extends SelectListView
    initialize: (@projectPaths) ->
      super
      @setItems @projectPaths.map (path) -> {path: path}
      @show()
      @focusFilterEditor()

    show: ->
      @panel ?= atom.workspace.addModalPanel item: this
      @panel.show()

    cancelled: ->
      @hide()

    hide: ->
      @panel?.destroy()

    viewForItem: ({path}) ->
      $$ ->
        @li path

    confirmed: ({path}) ->
      require('./open-github-app')(path)
      @cancel()
