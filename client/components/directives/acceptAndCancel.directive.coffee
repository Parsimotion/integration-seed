app

.directive "acceptandcancel", ->
  template = """
<aside class="button-container">
  <div ng-show="isVisible()">
    <input ng-show="isAcceptVisible()" type="submit" ng-value="{{ 'saveLabel' | translate }}" class="btn btn-success"/><a href="" ng-click="cancel()" class="cancel-link">{{ 'cancelLabel' | translate }}</a>
  </div>
</aside>
  """

  template: template
  restrict: "E"
  replace: true
  scope: true

  controller: ($scope, $attrs, $parse) ->
    tryParse = (attr) -> try $parse($attrs[attr]) $scope

    $scope.isVisible = ->
      tryParse("isVisible") or true

    $scope.isAcceptVisible = ->
      tryParse("isAcceptVisible") or true

    $scope.cancel = ->
      tryParse("onCancel")

    $scope.$on "save", (e, options) ->
      tryParse("onAccept")

    @

.directive "withAcceptAndCancel", ($parse) ->
  restrict: "A"
  require: "form"
  scope: false

  link: (scope, formElement, attributes, form) ->
    form.attempt = false
    formElement.bind "submit", ->
      form.attempt = true
      scope.$apply() unless scope.$$phase
      if !form.$valid then return
      scope.$broadcast 'save', $parse(attributes.watcherSubmit)(scope)
