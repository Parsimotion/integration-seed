app.controller 'LoadingCtrl', ($scope, $rootScope) ->
  $rootScope.$on '$stateChangeStart', ->
    $scope.isLoading = true

  $rootScope.$on '$stateChangeSuccess', ->
    $scope.isLoading = false
