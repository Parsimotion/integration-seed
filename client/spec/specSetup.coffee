$httpBackend = null
$scope = null
getController = null

beforeEach ->
  module "integration-seed-app"

  inject ($controller, $rootScope, _$httpBackend_) ->
    $httpBackend = _$httpBackend_
    $scope = $rootScope.$new()
    $httpBackend.whenGET(/\/locale/ ).respond {}

    getController = (name, dependencies) ->
      defaults = _.partialRight(_.assign, (a, b) ->
        (if typeof a is "undefined" then b else a)
      )

      defaultDependencies =
        $scope: $scope
        $httpBackend: $httpBackend

      $controller name, (defaults defaultDependencies, dependencies)

describe "remove me", ->
  it "dummy", ->
    expect(true).toBeTruthy()
