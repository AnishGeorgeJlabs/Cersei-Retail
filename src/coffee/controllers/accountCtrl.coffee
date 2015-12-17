angular.module('app.controllers')
.controller('AccountCtrl', [
    '$scope', 'csApiEndpoints', 'agHttp', 'csUserCreds', '$state',
    ($scope, csApiEndpoints, agHttp, csUserCreds, $state) ->
      if not csUserCreds.isLoggedIn()
        $state.go('login')
      agHttp.get(csApiEndpoints.account)
      .then(
        (data) ->
          $scope.data = data
          console.log "Got account data: #{JSON.stringify($scope.data)}"
      )
])
