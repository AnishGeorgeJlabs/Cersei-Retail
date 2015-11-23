angular.module('app.services')
.factory('csOrderOps', [
    '$interval', '$rootScope', 'csApiEndpoints', 'csAudioAlert', 'agHttp',
    ($interval, $rootScope, csApiEndpoints, csAudioAlert, agHttp) ->
      order_list = []
      callback = null


      get_list = () ->
        agHttp.get(csApiEndpoints.orders)
        .then(
          (data) ->
            order_list = data
            if callback != null
              callback(order_list)
        , (reason) ->
          console.log "failed order_list: #{JSON.stringify(reason)}"
        )

      rep = null
      # $rootScope.$on("app:login", () ->
      #   rep = $interval(get_list, 5000)
      # )

      cleanup = () ->
        $interval.cancel(rep)
        order_list = []

      $rootScope.$on("app:logout", cleanup)
      $rootScope.$on("$destroy", cleanup)

      return {

        register_callback: (fn) ->
          callback = fn
          if order_list.length == 0
            get_list()
          else
            callback(order_list)

      }

  ])
