angular.module 'app.services'
.factory('csAudioAlert', ['$cordovaMedia', '$ionicPlatform', '$rootScope', ($cordovaMedia, $ionicPlatform, $rootScope) ->
    audio =
      stop: () ->
      play: () ->
      setVolume: () ->

    mute = false
    $ionicPlatform.ready(() ->
      audio = $cordovaMedia.newMedia(window.cordova.file.applicationDirectory + "www/sound/ringer.mp3")
      console.log "Playing audio initially, can you hear me?"
    )
    $rootScope.$on("app:log_out", () ->
      audio.stop()
    )

    return {
      play: () ->
        audio.stop()
        audio.play()
      stop: () -> audio.stop()
      toggle_mute: () ->
        console.log "toggle Mute"
        if mute
          audio.setVolume(1.0)
        else
          audio.setVolume(0.0)
        mute = not mute
      is_mute: () -> mute
    }
  ])
