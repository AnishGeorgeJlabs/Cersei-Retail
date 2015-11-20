angular.module('app.controllers')
.controller('OrdersCtrl', ['$scope', 'csOrderOps', ($scope, csOrderOps) ->
  $scope.orders = []
  csOrderOps.register_callback((data) ->
    $scope.orders = data
  )
])
