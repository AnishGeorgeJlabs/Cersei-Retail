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
            if data.length > 0
              csAudioAlert.play()
            else
              csAudioAlert.stop()
            if callback != null
              callback(order_list)
        , (reason) ->
          console.log "failed order_list: #{JSON.stringify(reason)}"
        )

      rep = null
      rep = $interval(get_list, 5000)
      $rootScope.$on("app:login", () ->
        if rep != null
          $interval.cancel(rep)
        rep = $interval(get_list, 5000)
      )

      cleanup = () ->
        if rep != null
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
