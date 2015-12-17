angular.module('app.controllers')
.controller('AccountCtrl', [
    '$scope', 'csApiEndpoints', 'agHttp', 'csUserCreds', '$state',
    ($scope, csApiEndpoints, agHttp, csUserCreds, $state) ->
      $scope.loading = true
      if not csUserCreds.isLoggedIn()
        $state.go('login')
      agHttp.get(csApiEndpoints.account)
      .then(
        (data) ->
          $scope.data = data
          $scope.loading = false
      )
])
