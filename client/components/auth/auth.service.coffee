angular.module 'integration-seed-app'
.factory 'Auth', (User) ->
  currentUser = User.get()

  ###
  Gets all available info on authenticated user

  @return {Object} user
  ###
  getCurrentUser: ->
    currentUser
