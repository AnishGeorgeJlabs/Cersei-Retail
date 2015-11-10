angular.module 'app'
.config([
    '$stateProvider', '$urlRouterProvider', '$ionicConfigProvider',

    ($stateProvider, $urlRouterProvider, $ionicConfigProvider) ->

      $stateProvider
      .state('tabs',
        url: '/tab'
        abstract: true
        templateUrl: 'templates/tabs.html'
      )
      .state('login',
        url: '/login'
        templateUrl: 'templates/login.html'
      )
      .state('tabs.orders',
        url: '/orders'
        views:
          order_tab:
            templateUrl: 'templates/orders.html'
      )
      .state('tabs.account',
        url: '/account'
        views:
          account_tab:
            templateUrl: 'templates/account.html'
      )
      $urlRouterProvider.otherwise('/login')
  ])
