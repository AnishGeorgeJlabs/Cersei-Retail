angular.module 'app.services'
.factory('agEncPass', () ->
  (password) ->
    CryptoJS.MD5(password).toString(CryptoJS.enc.Hex)
)
