angular.module 'app.controllers'
.controller("NewOrderCtrl", [
    '$scope', 'csUserCreds', '$state',
    ($scope, csUserCreds, $state) ->
      if not csUserCreds.isLoggedIn()
        $state.go('login')
      $scope.current = [
        {
          name: "Act II Popcorn"
          price: 50
          qty: 2
          points: 30
        },
        {
          name: "Kissan Tomato Ketchup with a lot of additional text just for testing purposes as some of the stuff is long"
          price: 100
          qty: 1
          points: 10
        }
      ]
])
