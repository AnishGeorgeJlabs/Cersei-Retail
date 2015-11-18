angular.module 'app.services'
.factory('csUserCreds', ['$q', '$log', '$rootScope', 'csApiEndpoints', 'agEncPass', 'agHttp',
    ($q, $log, $rootScope, tyApiEndpoints, agEncPass, agHttp) ->
      ###
        This service manages the user credentials and the login and logout process
        Mainly, it interfaces with the agHttp service to register the api_key and vendor_id once received
      ###
      username = ''
      return {
      username: () -> username
      isLoggedIn: () -> Boolean(username)
      logout: () ->
        username = ''
        agHttp.setApiCreds('', 0)
        $rootScope.$emit("app:log_out")
      login: (user, password) ->
        pass = agEncPass(password)

        agHttp.post(tyApiEndpoints.login,
          username: user
          password: pass
        ).then((data) ->
          username = user
          agHttp.setApiCreds(data.api_key, data.vendor_id)
          broad = {name: data.name, address: data.address}
          $rootScope.$emit("app:logged_in", broad)
          username
        )
      change_pass: (user, old_pass, new_pass) ->
        real_old_pass = agEncPass(old_pass)
        real_new_pass = agEncPass(new_pass)

        agHttp.post(tyApiEndpoints.change_pass,
          username: user
          old_pass: real_old_pass
          new_pass: real_new_pass
        )
      }
  ])
