'use strict'

window.app = angular.module 'integration-seed-app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'pascalprecht.translate'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true

# i18n
.config ($translateProvider) ->
  $translateProvider.useUrlLoader '/locale'
  $translateProvider.useSanitizeValueStrategy(null)
  $translateProvider.determinePreferredLanguage() 