angular.module 'app.controllers'
.controller("NewOrderCtrl", [
    '$scope',
    ($scope) ->
      $scope.current = [
        {
          name: "Act II Popcorn"
          price: 50
          qty: 2
          points: 30
        },
        {
          name: "Kissan Tomato Ketchup"
          price: 100
          qty: 1
          points: 10
        }
      ]
])
