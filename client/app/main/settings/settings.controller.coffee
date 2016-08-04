app.controller 'SettingsCtrl', (settings) ->
  new class SettingsCtrl
    constructor: ->
      @settings = settings
