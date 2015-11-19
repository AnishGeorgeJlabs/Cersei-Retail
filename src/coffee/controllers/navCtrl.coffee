angular.module 'app.controllers'
.controller('NavCtrl', ['$scope', 'csAudioAlert', '$state', '$ionicHistory', ($scope, csAudioAlert, $state, $ionicHistory) ->
    $scope.stateCheck = (name) ->
      $state.is(name)

    $scope.goBack = () ->
      if $state.is("account") or $state.is("changePass")
        $state.go("orders")
      else
        $ionicHistory.goBack()

    $scope.backEnabled = () ->
      not ($state.is("login") or $state.is("orders"))

  ])
