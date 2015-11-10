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
  ])
