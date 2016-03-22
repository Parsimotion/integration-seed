'use strict'

angular.module 'integration-seed-app'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    abstract: true
    url: '/'
    templateUrl: 'app/main/main.html'
  .state 'main.settings',
    url: 'settings'
    templateUrl: 'app/main/settings/settings.html'
    controller: 'SettingsCtrl'
