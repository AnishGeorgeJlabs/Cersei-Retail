angular.module 'app.controllers'
.controller('OrderDetailsCtrl', [
    '$scope', '$state', '$stateParams', 'csUserCreds', 'agHttp', 'csApiEndpoints', 'csScanner', '$cordovaToast', '$ionicPopup',
    ($scope, $state, $stateParams, csUserCreds, agHttp, csApiEndpoints, csScanner, $cordovaToast, $ionicPopup) ->

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

      $scope.total = () ->
        sum = 0
        sum += item.pts for item in $scope.order
        sum

      $scope.accept = () ->
        $ionicPopup.confirm(
          title: "Confirm send"
          content: "Confirm the order? You cannot make any further changes"
          okType: 'button-clear button-small button-balanced'
          okText: 'Yes'
          cancelType: 'button-clear button-small'
          cancelText: 'No'
        ).then(
          (res) ->
            if res
              all_codes = []
              for item in $scope.order
                all_codes = all_codes.concat(item.scanned)
              agHttp.post(csApiEndpoints.order_update,
                order_id: $scope.details.order_id
                status: "accepted"
                order_codes: all_codes
              ).then(
                (pts) ->
                  console.log "You gained #{pts} points"
                  $cordovaToast.showShortBottom("You gained #{pts} points")
                , (error) ->
                  console.log "Got an error: " + error
              )
              $state.go "orders"
        )

      $scope.cancel = () ->
        $ionicPopup.confirm(
          title: "Cancel the order?"
          content: "Are you sure you want to cancel the order?"
          okType: 'button-clear button-small button-assertive'
          okText: 'Yes'
          cancelType: 'button-clear button-small'
          cancelText: 'No'
        ).then(
          (res) ->
            if res
              agHttp.post(csApiEndpoints.order_update,
                order_id: $scope.details.order_id
                status: "cancelled"
              )
              $state.go "orders"
        )

      ### For testing only
      $scope.scan = (index) ->
        $scope.order[index].scanned.push(10)

      ###

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
                if item.scanned.length < item.qty and text not in item.scanned
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
