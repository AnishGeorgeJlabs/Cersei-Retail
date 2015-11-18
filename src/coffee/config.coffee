angular.module 'app'
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
      )
      .state('orders',
        url: '/orders'
        templateUrl: 'templates/orders.html'
      )
      .state('account',
        url: '/account'
        templateUrl: 'templates/account.html'
      )
      $urlRouterProvider.otherwise('/login')
  ])
