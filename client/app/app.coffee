window.app = angular.module 'integration-seed-app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'pascalprecht.translate'
  'resource.watcher'
  'SmoothScroll'
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
