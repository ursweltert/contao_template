#= require jquery
#= require jquery-migrate-min
#= require jquery_ujs
#= require jquery.ui.all
#= require twitter/bootstrap
#= require jasny/jasny-bootstrap
#= require Swiper/idangerous.swiper-1.9.3
#= require mediaelement_rails
#= require GSAP/uncompressed/TweenMax
#= require GSAP/uncompressed/jquery.gsap


# jQuery Plugins
# TODO: als Sprockets require in eigene Datei auslagern
(($) ->
  $.fn.clearText = ->
    $(this).each ->
      defautVal = $(this).val()
      $(this).focus(->
        $(this).val ""  if $(this).val() is defautVal
      ).blur ->
        $(this).val defautVal  if $(this).val() is ""
) jQuery

# Namespaces ermöglichen, Quelle: https://github.com/jashkenas/coffee-script/wiki/FAQ
namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

# Beispiel:
# # how to define a class in the namespace, using said namespace sample
# namespace 'Secrets', (exports) ->
#   class exports.Hello
#     constructor: ->
#       @message = "Secret Hello!"

# # test of the namespaced class
# a = new Secrets.Hello
# console.log a.message

namespace 'Page', (exports) ->
  class exports.Swiper
    constructor: (options) ->
      {@swiperContainer, @swiperObject, @autoPlay, @withPagination} = options

      @swiperObject =
        slider: []
        sliderId: []
        navigation: []

      $(@swiperContainer).each (idx, el) =>

        $(el).uniqueId()
        $(el).addClass ->
          $(this).attr('id')
        sliderId = $(el).attr('id')
        @swiperObject.sliderId.push ->
          sliderId
        @swiperObject.sliderId[idx] = @swiperObject.sliderId[idx]()

        $(el).next().uniqueId()
        $(el).next().addClass ->
          $(this).attr('id')
        elId = $(el).next().attr('id')
        @swiperObject.navigation.push ->
          elId
        @swiperObject.navigation[idx] = @swiperObject.navigation[idx]()

        @swiperObject.slider.push =>
          $(el).swiper(
            autoPlay: @autoPlay
            grabCursor: true
            pagination: '.' + @swiperObject.navigation[idx]
          )
        @swiperObject.slider[idx] = @swiperObject.slider[idx]()
        # console.log @swiperObject.slider[idx]

      # Paginierung ?
      if @withPagination
        @swiperObject.navigation.each (navEl, navIdx) =>
          $('.' + navEl + ' a').each (linkIdx, linkEl) =>
            $(linkEl).click( (event) =>
              event.preventDefault()
              # Slideshow anhalten
              @swiperObject.slider[navIdx].stopAutoPlay()

              slideNr = $(event.target).data('slide')
              # zum neuen Slide navigieren
              @swiperObject.slider[navIdx].swipeTo(slideNr, 1000)
              # Slideshow fortsetzen
              @swiperObject.slider[navIdx].startAutoPlay()
            )
      # Höhe der einzelnen Slider-Elemente korrigieren
      $(window).load =>
        @setSlideHeigth()

      $(window).resize =>
        @setSlideHeigth()

      # Pausieren / Starten, wenn der Mauszeiger über dem Slider ist
      $(@swiperContainer).mouseenter( (event) =>
        @swiperObject.slider.each (sliderEl, sliderIdx) ->
          sliderEl.stopAutoPlay()
      )
      $(@swiperContainer).mouseleave( (event) =>
        @swiperObject.slider.each (sliderEl, sliderIdx) ->
          sliderEl.startAutoPlay()
      )
    # Höhe der einzelnen Slider Inhalte korrigieren
    setSlideHeigth: ->
      @swiperObject.slider.each (sliderEl, sliderIdx) =>
        slideHeight = $(sliderEl.container).find('.swiper-slide *').height() + 20
        $('.' + @swiperObject.sliderId[sliderIdx] + ', .swiper-slide').height(slideHeight)
        sliderEl.resizeFix()

  class exports.MediaPlayer
    constructor: ({@elements, @loop, @autoPlay, @features} = {}) ->
      # initialisieren
      @loop ?= false
      @autoPlay ?= false
      @features ?= ['playpause','progress','current','duration','tracks','volume','fullscreen']

      @players = []
      @playerElements = []

      $(@elements).each (mediaIdx, mediaEl) =>
        $(mediaEl).uniqueId()

        @options =
          # if the <video width> is not specified, this is the default
          defaultVideoWidth: 480
          # if the <video height> is not specified, this is the default
          defaultVideoHeight: 270
          # if set, overrides <video width>
          videoWidth: -1
          # if set, overrides <video height>
          videoHeight: -1
          # width of audio player
          # audioWidth: 400
          # height of audio player
          # audioHeight: 30
          # initial volume when the player starts
          startVolume: 0.8
          # useful for <audio> player loops
          loop: @loop
          # enables Flash and Silverlight to resize to content size
          enableAutosize: true
          # the order of controls you want on the control bar (and other plugins below)
          features: @features
          # Hide controls when playing and mouse is not over the video
          alwaysShowControls: false
          # force iPad's native controls
          iPadUseNativeControls: false
          # force iPhone's native controls
          iPhoneUseNativeControls: false
          # force Android's native controls
          AndroidUseNativeControls: false
          # forces the hour marker (##:00:00)
          alwaysShowHours: false
          # show framecount in timecode (##:00:00:00)
          showTimecodeFrameCount: false
          # used when showTimecodeFrameCount is set to true
          framesPerSecond: 25
          # turns keyboard support on and off for this instance
          enableKeyboard: true
          # when this player starts, it will pause other players
          pauseOtherPlayers: false
          #array of keyboard commands
          keyActions: []

        # console.log @options.videoWidth

        @playerElements[mediaIdx] = $(mediaEl).mediaelementplayer(@options)

        if @autoPlay
          $(@playerElements[mediaIdx])[0].player.play()

        # $(window).resize =>
        #   videoContainerWidth = $(mediaEl).parents('.mod_article').outerWidth()

        #   console.log videoContainerWidth

        #   @options.videoWidth = videoContainerWidth
        #   $(mediaEl).attr('width', @options.videoWidth)
        #   console.log @options
        #   @playerElements[mediaIdx] = $(mediaEl).mediaelementplayer(@options)

        @players[mediaIdx] = $(@playerElements[mediaIdx])[0].player

jQuery ->
  # Standardwerte von Formularfeldern löschen/wiederherstellen
  $('input[type=text]').clearText()

  if $('video').length != 0
    videos = $('video')
    videoOptions =
      elements    : videos
      features    : ['playpause','progress','current','duration','fullscreen']
    namespace 'Page', (exports) ->
      exports.videoPlayer = new Page.MediaPlayer(videoOptions)

  checklistItem = $('.checkliste td.col_last')
  checklistItem.each (idx, el) ->
    if $(el).text() == "'"
      $(el).attr('data-content', 'nein')
    if $(el).text() == "."
      $(el).attr('data-content', 'ja')

  if $('.swiper-container').length != 0
    # Swiper für die Contao Galerie starten
    swiperOptions =
      swiperContainer : '.swiper-container'
      swiperObject    : {}
      autoPlay        : 5000
      withPagination  : true

    namespace 'Page', (exports) ->
      exports.gallerySwiper = new Page.Swiper(swiperOptions)
