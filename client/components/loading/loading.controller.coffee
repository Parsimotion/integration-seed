app.controller 'LoadingCtrl', ($scope, $rootScope) ->
  $rootScope.$on '$stateChangeStart', ->
    $scope.isLoading = true

  $rootScope.$on '$stateChangeSuccess', ->
    $scope.clearError()
    $scope.isLoading = false
