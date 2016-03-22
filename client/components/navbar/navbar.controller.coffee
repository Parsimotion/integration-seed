'use strict'

app.controller 'NavbarCtrl', ($scope, $state) ->
  $scope.path = -> $state.current.name.split "."
  $scope.getUrl = (index) ->
    stateName = _.take($scope.path(), index + 1).join "."
    $state.href stateName
  $scope.stateIncludes = (substring) ->
    _.includes $state.current.name, substring
