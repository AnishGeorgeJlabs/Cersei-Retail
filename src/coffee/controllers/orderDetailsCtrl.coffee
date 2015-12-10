angular.module 'app.controllers'
.controller('OrderDetailsCtrl', [
    '$scope', '$state', '$stateParams', 'csUserCreds', 'agHttp', 'csApiEndpoints', 'csScanner', '$cordovaToast'
    ($scope, $state, $stateParams, csUserCreds, agHttp, csApiEndpoints, csScanner, $cordovaToast) ->

      $scope.loading = true

      agHttp.get(csApiEndpoints.order_details, {order_id: $stateParams.order_id})
      .then(
        (data) ->
          $scope.order = data.order

          # todo, add local storage options so that this can be saved and order completed in parts
          for item in $scope.order
            item.scanned = []
            item.pts = 0

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

      $scope.coScan = () ->
        csScanner((text) ->
          agHttp.get(csApiEndpoints.scan, {
            code: text
          }).then(
            (data) ->
              # first match the correct barcode
              f = false
              for item in $scope.order when item.barcode == data.barcode
                f = true
                if item.scanned.length < item.qty
                  item.scanned.push(text)
                  item.pts += data.pts
                $cordovaToast.showShortBottom("#{item.name} scanned")
                console.log "#{item.name} scanned"
                break
              if not f
                $cordovaToast.showShortBottom("Item not found in order")
                console.log "Item not found"
          , (error) ->
              console.log "#{JSON.stringify(error)}"
          )
          true
        )
])
