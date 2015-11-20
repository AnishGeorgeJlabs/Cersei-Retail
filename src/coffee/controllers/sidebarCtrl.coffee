angular.module('app.controllers')
.controller('SidebarCtrl', ['$scope', 'csAudioAlert', 'csUserCreds', '$cordovaToast', '$state', '$rootScope',
    ($scope, csAudioAlert, csUserCreds, $cordovaToast, $state, $rootScope) ->
      $scope.is_mute = csAudioAlert.is_mute
      $scope.toggle_mute = csAudioAlert.toggle_mute

      $scope.logout = () ->
        csUserCreds.logout()
        $state.go 'login'
        $cordovaToast.showShortBottom("You have been successfully loggout out")

      $rootScope.$on("app:login", (evt, broad) ->
        $scope.merchant_name = broad.name
        $scope.address = broad.address
      )
  ])
