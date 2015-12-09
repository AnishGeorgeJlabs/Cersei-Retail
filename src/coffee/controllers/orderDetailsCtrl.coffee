angular.module 'app.controllers'
.controller('OrderDetailsCtrl', [
    '$scope', '$state', '$stateParams', 'csUserCreds', 'agHttp', 'csApiEndpoints', '$cordovaBarcodeScanner',
    ($scope, $state, $stateParams, csUserCreds, agHttp, csApiEndpoints, $cordovaBarcodeScanner) ->

      ###
      if not csUserCreds.isLoggedIn()
        $state.go('login')

      ###

      $scope.loading = true

      agHttp.get(csApiEndpoints.order_details, {order_id: $stateParams.order_id})
      .then(
        (data) ->
          $scope.order = data.order

          # todo, add local storage options so that this can be saved and order completed in parts
          for item in $scope.order
            item.scanned = []

          delete data.order
          $scope.details = data
          console.log "Got order: #{JSON.stringify($scope.order)}"
          console.log "And details: #{JSON.stringify($scope.details)}"
          $scope.loading = false
        , (failure) ->
          console.log "Failed to fetch details"
      )

      $scope.scan = (index) ->
        $scope.order[index].scanned.push(10)

      $scope.total_points = (index) ->
        $scope.order[index].scanned.reduce (t,s) -> t + s

      $scope.coScan = () ->
        $cordovaBarcodeScanner
        .scan()
        .then(
          (data) ->
            console.log "Success:: #{JSON.stringify(data)}"
            if not data.cancelled
              console.log "Going at it again"
              $scope.coScan()
            else
              console.log "Not going at it again"
          , (error) ->
            console.log "Failure:: #{JSON.stringify(error)}"
        )
])
