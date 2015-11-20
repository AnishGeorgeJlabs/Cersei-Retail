angular.module('app.controllers')
.controller('SidebarCtrl', ['$scope', 'csAudioAlert', 'csUserCreds', '$cordovaToast', '$state',
    ($scope, csAudioAlert, csUserCreds, $cordovaToast, $state) ->
      $scope.is_mute = csAudioAlert.is_mute
      $scope.toggle_mute = csAudioAlert.toggle_mute

      $scope.logout = () ->
        csUserCreds.logout()
        $state.go 'login'
        $cordovaToast.showShortBottom("You have been successfully loggout out")

      $scope.$on("app:login", (evt, broad) ->
        console.log "app login on scope"
        $scope.merchant_name = broad.name
        $scope.address = broad.address
      )
  ])
