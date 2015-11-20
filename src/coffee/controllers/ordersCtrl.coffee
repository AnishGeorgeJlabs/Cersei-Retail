angular.module('app.controllers')
.controller('OrdersCtrl', ['$scope', 'csOrderOps', ($scope, csOrderOps) ->
  $scope.order_list = []
  csOrderOps.register_callback((data) ->
    $scope.order_list = data
  )
])
