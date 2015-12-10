angular.module 'app.services'
.factory('csScanner', [ '$cordovaBarcodeScanner',
    ($cordovaBarcodeScanner) ->
      (processFn) ->
        current = arguments.callee
        $cordovaBarcodeScanner
        .scan()
        .then(
          (data) ->
            if not data.cancelled
              res = processFn(data.text)
              if res
                current(processFn)   # Fancy but only way of recursing the current annonymous function
        , (error) ->
          console.log "Failure:: #{JSON.stringify(error)}"
        )

])
