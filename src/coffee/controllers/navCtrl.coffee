angular.module 'app.controllers'
.controller('NavCtrl', ['$scope', 'csAudioAlert', '$state', '$ionicHistory', ($scope, csAudioAlert, $state, $ionicHistory) ->
    $scope.stateCheck = (name) ->
      $state.is(name)

    $scope.goBack = () -> $ionicHistory.goBack()
  ])
