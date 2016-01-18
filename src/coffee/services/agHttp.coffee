angular.module 'app.services'
.factory('agHttp', ['$http', '$q', '$cordovaToast',
    ($http, $q, $cordovaToast) ->
      apiCreds = {
        api_key: ''
        vendor_id: 0
      }

      deferPromise = (httpPromise) ->
        return $q((resolve, reject) ->
          httpPromise.then(
            (d) ->
              if d.data.success
                resolve(d.data.data)
              else
                reject(d.data.reason || d.data.error)
          , (d) ->
            $cordovaToast.showShortBottom("Could not connect to server, please check your internet connection") # Add a toast notification right here
            reject()
          )
        )
      return {
      setApiCreds: (api_key, vendor_id) ->
        apiCreds.api_key = api_key
        apiCreds.vendor_id = vendor_id

      get: (url, params) ->
        if apiCreds.api_key
          if params == undefined
            params = {}
          params.api_key = apiCreds.api_key
          params.vendor_id = apiCreds.vendor_id
          params.user_type = "vendor"

        return deferPromise($http.get(url, {params: params}))

      post: (url, data) ->
        data.user_type = "vendor"
        if apiCreds.api_key
          data.api_key = apiCreds.api_key
          data.vendor_id = apiCreds.vendor_id
        return deferPromise($http.post(url, data))
      }
  ])
