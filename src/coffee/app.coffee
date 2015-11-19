angular.module 'app', ['ionic', 'ngCordova', 'app.controllers', 'app.services', 'app.config']
.run([
    '$ionicPlatform', '$ionicPopup', '$state'

    ($ionicPlatform, $ionicPopup, $state) ->
      # ----- Basic keyboard setup and all ------------------------ #
      $ionicPlatform.ready(() ->
        if window.cordova and window.cordova.plugins.Keyboard
          cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
        if window.StatusBar
          # org.apache.cordova.statusbar required
          StatusBar.styleDefault()
      )

      # ----- Hardware back button handling ----------------------- #
      $ionicPlatform.registerBackButtonAction(() ->
        if $state.is('orders')
          $ionicPopup.confirm(
            title: "exit application?"
            content: "Are you sure you want to exit the application?"
            okType: 'button-clear button-small button-assertive'
            okText: 'exit'
            cancelType: 'button-clear button-small'
            cancelText: 'cancel'
          ).then(
            (res) ->
              if res
                navigator.app.exitApp()
          )
        else if $state.is("account")
          $state.go("orders")
        else
          $ionicHistory.goBack()
      , 100)
  ])

# Declarations for all the modules here, so that concatenation and minification can go smoothly
angular.module('app.services', [])
angular.module('app.controllers', [])
