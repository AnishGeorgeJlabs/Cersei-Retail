angular.module 'app.controllers'
.controller('OrderDetailsCtrl', [
    '$scope', '$state', '$stateParams', 'csUserCreds', 'agHttp', 'csApiEndpoints',
    ($scope, $state, $stateParams, csUserCreds, agHttp, csApiEndpoints) ->

      ###
      if not csUserCreds.isLoggedIn()
        $state.go('login')

      ###

      $scope.loading = true

      agHttp.get(csApiEndpoints.order_details, {order_id: $stateParams.order_id})
      .then(
        (data) ->
          $scope.order = data.order
          delete data.order
          $scope.details = data
          console.log "Got order: #{JSON.stringify($scope.order)}"
          console.log "And details: #{JSON.stringify($scope.details)}"
          $scope.loading = false
        , (failure) ->
          console.log "Failed to fetch details"
      )
])
