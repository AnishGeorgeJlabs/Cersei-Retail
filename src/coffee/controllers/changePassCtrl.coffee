angular.module('app.controllers')
.controller('ChangePassCtrl', ['$scope', '$state', 'csUserCreds', '$cordovaToast',
    ($scope, $state, csUserCreds, $cordovaToast) ->
      if not csUserCreds.isLoggedIn()
        $state.go('login')
      $scope.data =
        username: csUserCreds.username()
        old_pass: ''
        new_pass: ''
        new_pass_r: ''

      $scope.loading = false

      $scope.submit = () ->
        if $scope.data.new_pass == $scope.data.new_pass_r
          if $scope.data.new_pass == $scope.data.old_pass
            $cordovaToast.showShortBottom("The old and new passwords appear to be the same")
          else
            $scope.loading = true
            csUserCreds.change_pass($scope.data.username, $scope.data.old_pass, $scope.data.new_pass)
            .then((result) ->
              if result
                $cordovaToast.showShortBottom("The password was changed successfully")
                $state.go 'orders'
              else
                $cordovaToast.showLongBottom("Authentication error")
                $state.go("login")
            )
        else
          $cordovaToast.showShortBottom("The passwords do not match")

      $scope.cancel = () ->
        $state.go 'orders'
  ])
