angular.module 'app.services'
.provider('csApiEndpoints', () ->
  ###
    This service provides for all the api endpoints for tyrion,
    It is configurable to point to the actual amazon web service or the locally running development server
  ###
  externalHost = "http://lannister-api.elasticbeanstalk.com/cersei/"
  localHost = "http://127.0.0.1:8000/cersei/"

  host = externalHost

  useLocalHost: (b) ->
    if Boolean(b)
      host = localHost
    else
      host = externalHost

  $get: () ->
    return {
    echo: host
    login: host + "auth/login"
    change_pass: host + "auth/change_pass"
    orders: host + "orders"
    order_details: host + "orders/details"
    }
)
