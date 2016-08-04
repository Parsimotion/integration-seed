app.factory "Settings", (resource, $injector) ->
  class Settings extends resource "/api/settings/:id"
    _isExisting: -> true
