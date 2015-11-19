angular.module('app.controllers')
.controller('SidebarCtrl', ['$scope', 'csAudioAlert', 'csUserCreds', '$cordovaToast', '$state',
    ($scope, csAudioAlert, csUserCreds, $cordovaToast, $state) ->
      $scope.is_mute = csAudioAlert.is_mute
      $scope.toggle_mute = csAudioAlert.toggle_mute

      $scope.logout = () ->
        csUserCreds.logout()
        $state.go 'login'
        $cordovaToast.showShortBottom("You have been successfully loggout out")
  ])
