angular.module('app.controllers')
.controller('OrdersCtrl', [
    '$scope', '$state', 'csOrderOps', 'csUserCreds', '$rootScope',
    ($scope, $state, csOrderOps, csUserCreds, $rootScope) ->

      if not csUserCreds.isLoggedIn()
        $state.go('login')

      $scope.orders = []
      csOrderOps.register_callback((data) ->
        $scope.orders = data
      )
])
