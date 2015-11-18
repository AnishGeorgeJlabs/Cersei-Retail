angular.module 'app.controllers'
.controller('NavCtrl', ['$scope', 'csAudioAlert', '$state', ($scope, csAudioAlert, $state) ->
    $scope.is_mute = csAudioAlert.is_mute
    $scope.toggle_mute = csAudioAlert.toggle_mute

    $scope.backDisabled = () ->
      $state.is("orders")

    $scope.menuDisabled = () ->
      $state.is("login")
  ])
