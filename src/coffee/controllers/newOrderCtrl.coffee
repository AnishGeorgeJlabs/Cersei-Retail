angular.module 'app.controllers'
.controller("NewOrderCtrl", [
    '$scope', 'csUserCreds', '$state', 'csApiEndpoints', 'agHttp', 'csScanner'
    ($scope, csUserCreds, $state, csApiEndpoints, agHttp, csScanner) ->
      if not csUserCreds.isLoggedIn()
        $state.go('login')

      $scope.current = []

      $scope.coScan = () ->
        csScanner((text) ->
          agHttp.get(csApiEndpoints.new_scan, {
            code: text
          }).then(
            (data) ->

          )
        )
])
