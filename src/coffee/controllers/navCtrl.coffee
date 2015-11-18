angular.module 'app.controllers'
.controller('NavCtrl', ['$scope', 'csAudioAlert', '$state', ($scope, csAudioAlert, $state) ->
    $scope.stateCheck = (name) ->
      $state.is(name)
  ])
