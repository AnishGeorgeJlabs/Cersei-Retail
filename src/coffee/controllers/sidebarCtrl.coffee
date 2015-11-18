angular.module('app.controllers')
.controller('SidebarCtrl', ['$scope', 'csAudioAlert', ($scope, csAudioAlert) ->
    $scope.is_mute = csAudioAlert.is_mute
    $scope.toggle_mute = csAudioAlert.toggle_mute
    $scope.logout = () ->
  ])
