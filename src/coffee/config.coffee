angular.module 'app.config', ['app.controllers', 'app.services']
.config([
    '$stateProvider', '$urlRouterProvider', '$ionicConfigProvider', 'csApiEndpointsProvider',

    ($stateProvider, $urlRouterProvider, $ionicConfigProvider, csApiEndpointsProvider) ->

      csApiEndpointsProvider.useLocalHost(true)

      $stateProvider
      .state('login',
        url: '/login'
        templateUrl: 'templates/login.html'
        controller: 'LoginCtrl'
      )
      .state('changePass',
        url: '/change_pass'
        templateUrl: 'templates/changePass.html'
        controller: 'ChangePassCtrl'
      )
      .state('orders',
        url: '/orders'
        templateUrl: 'templates/orders.html'
        controller: 'OrdersCtrl'
      )
      .state('account',
        url: '/account'
        templateUrl: 'templates/account.html'
        controller: 'AccountCtrl'
      )
      .state('orderDetails',
        url: '/details'
        templateUrl: 'templates/orderDetails.html'
        controller: 'OrderDetailsCtrl'
      )
      .state('newOrder',
        url: '/new'
        templateUrl: 'templates/newOrder.html'
        controller: 'NewOrderCtrl'
      )
      $urlRouterProvider.otherwise('/login')
  ])
