window.app = angular.module 'integration-seed-app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'pascalprecht.translate'
  'resource.watcher'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/settings'

  $locationProvider.html5Mode true

# Auth
.config ($httpProvider, ACCESS_TOKEN) ->
  $httpProvider.defaults.headers.common.Authorization = "Bearer #{ACCESS_TOKEN}"

# i18n
.config ($translateProvider) ->
  $translateProvider.useUrlLoader '/locale'
  $translateProvider.useSanitizeValueStrategy(null)
  $translateProvider.determinePreferredLanguage()

# Errors
.run ($rootScope) ->
  $rootScope.setError = (error) ->
    $rootScope.error = error

  $rootScope.clearError = ->
    $rootScope.error = null

# Load
.run ($rootScope) ->
  $rootScope.load = (promise) ->
    $rootScope.isLoading = true
    promise
      .catch (e) ->
        if e.status is 400 and e.data?.code?
          $rootScope.setError "error.#{e.data.code}"
        throw e
      .finally ->
        $rootScope.isLoading = false
