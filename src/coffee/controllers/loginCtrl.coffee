angular.module('app.controllers')
.controller('LoginCtrl', [ '$scope', '$state', 'csUserCreds', '$cordovaToast', '$ionicHistory',
    ($scope, $state, csUserCreds, $cordovaToast, $ionicHistory) ->
      $scope.data =
        username: ''
        password: ''

      $scope.loading = false

      $scope.submit = () ->
        $scope.loading = true
        csUserCreds.login(
          $scope.data.username,
          $scope.data.password
        ).then(
          (username) ->
            $state.go 'orders'
            $scope.loading = false
            $cordovaToast.showShortBottom("Logged in as #{username}")
        , (reason) ->
          if reason
            $cordovaToast.showLongBottom("Login failed: "+reason, "error")
          $scope.loading = false
        )
  ])
