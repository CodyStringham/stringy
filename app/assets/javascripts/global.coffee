$ ->
  theLoader = $('#awesome-load-screen')
  setTimeout(->
    theLoader.addClass('offscreen')
  , 2000)
  setTimeout(->
    theLoader.remove()
  , 3500)

$ ->

  # Variable block
  fixNav = $('#fixed-nav')
  topJump = $('.top-jump')
  mobList = $('.mobile-nav-list')
  mobNav = $('.mobile-nav')
  wideScreen = false
  screenOffset = false

  # Function to get the page width
  getWidth = ->
    pageWidth = $(window).width()

  # Function to get the page offset
  getOffset = ->
    pageOffset = window.pageYOffset

  # Function that checks page offset for the scroll to top button
  checkScrollTop = (offset) ->
    if offset > 550 && screenOffset == false
      screenOffset = true
      topJump.addClass("top-jump-active")
      topJump.animate
        opacity: 1
      , 1000

    if offset < 550 && screenOffset == true
      screenOffset = false
      topJump.removeClass("top-jump-active")
      topJump.animate
        opacity: 0
      , 500

  # Function that checks the window width for the navigation displayed
  checkWideScreen = (width) ->
    if width > 641 && wideScreen == false
      wideScreen = true

    if width < 641 && wideScreen == true
      wideScreen = false

    if wideScreen == true && screenOffset == true
      fixNav.fadeIn()

    else
      fixNav.fadeOut()


  # Sets up a timer on scroll, clears after .025 seconds
  timer = undefined
  $(window).scroll ->
    window.clearTimeout timer if timer
    timer = window.setTimeout(->

      # Callback when timer is cleared
      checkScrollTop( getOffset() )
      checkWideScreen( getWidth() )
    , 25)

  # Sets up a timer on window resize, clears after .1 seconds
  $(window).resize ->
    window.clearTimeout timer if timer
    timer = window.setTimeout(->

      # Callback when timer is cleared
      checkWideScreen( getWidth() )
    , 100)


  # Function that animates on-page links over .8 seconds
  slideScroll = (element, navheight) ->
    root = $("body,html")
    offset = element.offset()
    offsetTop = offset.top
    totalScroll = offsetTop - navheight
    root.animate
      scrollTop: totalScroll
    , 800

  # Helper function that allows dynamic use of slideScroll
  scrollMaster = (element, mod) ->
    el = $(element).attr("href")
    elWrap = $(el)
    slideScroll elWrap, mod
    false

  # Uses slideScroll for the return to top link
  topJump.on "click", ->
    scrollMaster( $(this), 45 )

  # Uses slideScroll for the mobile navigation links
  mobList.on "click", "a", ->
    mobNav.removeClass("expanded")
    scrollMaster( $(this), 0 )









  # Slider
  (($, window, undefined_) ->
    "use strict"
    $.CatSlider = (options, element) ->
      @$el = $(element)
      @_init options
      return

    $.CatSlider:: =
      _init: (options) ->

        # the categories (ul)
        @$categories = @$el.children("ul")

        # the navigation
        @$navcategories = @$el.find("nav > a")
        animEndEventNames =
          WebkitAnimation: "webkitAnimationEnd"
          OAnimation: "oAnimationEnd"
          msAnimation: "MSAnimationEnd"
          animation: "animationend"


        # animation end event name
        @animEndEventName = animEndEventNames[Modernizr.prefixed("animation")]

        # animations and transforms support
        @support = Modernizr.csstransforms and Modernizr.cssanimations

        # if currently animating
        @isAnimating = false

        # current category
        @current = 0
        $currcat = @$categories.eq(0)
        unless @support
          @$categories.hide()
          $currcat.show()
        else
          $currcat.addClass "serv-current"

        # current nav category
        @$navcategories.eq(0).addClass "serv-selected"

        # initialize the events
        @_initEvents()
        return

      _initEvents: ->
        self = this
        @$navcategories.on "click.catslider", ->
          self.showCategory $(this).index()
          false


        # reset on window resize..
        $(window).on "resize", ->
          self.$categories.removeClass().eq(0).addClass "serv-current"
          self.$navcategories.eq(self.current).removeClass("serv-selected").end().eq(0).addClass "serv-selected"
          self.current = 0
          return

        return

      showCategory: (catidx) ->
        return false  if catidx is @current or @isAnimating
        @isAnimating = true

        # update selected navigation
        @$navcategories.eq(@current).removeClass("serv-selected").end().eq(catidx).addClass "serv-selected"
        dir = (if catidx > @current then "right" else "left")
        toClass = (if dir is "right" then "serv-moveToLeft" else "serv-moveToRight")
        fromClass = (if dir is "right" then "serv-moveFromRight" else "serv-moveFromLeft")

        # current category
        $currcat = @$categories.eq(@current)

        # new category
        $newcat = @$categories.eq(catidx)
        $newcatchild = $newcat.children()
        lastEnter = (if dir is "right" then $newcatchild.length - 1 else 0)
        self = this
        if @support
          $currcat.removeClass().addClass toClass
          setTimeout (->
            $newcat.removeClass().addClass fromClass
            $newcatchild.eq(lastEnter).on self.animEndEventName, ->
              $(this).off self.animEndEventName
              $newcat.addClass "serv-current"
              self.current = catidx
              $this = $(this)

              # solve chrome bug
              self.forceRedraw $this.get(0)
              self.isAnimating = false
              return

            return
          ), $newcatchild.length * 90
        else
          $currcat.hide()
          $newcat.show()
          @current = catidx
          @isAnimating = false
        return


      # based on http://stackoverflow.com/a/8840703/989439
      forceRedraw: (element) ->
        return  unless element
        n = document.createTextNode(" ")
        position = element.style.position
        element.appendChild n
        element.style.position = "relative"
        setTimeout (->
          element.style.position = position
          n.parentNode.removeChild n
          return
        ), 25
        return

    $.fn.catslider = (options) ->
      instance = $.data(this, "catslider")
      if typeof options is "string"
        args = Array::slice.call(arguments_, 1)
        @each ->
          instance[options].apply instance, args
          return

      else
        @each ->
          (if instance then instance._init() else instance = $.data(this, "catslider", new $.CatSlider(options, this)))
          return

      instance

    return
  ) jQuery, window

  $("#serv-slide").catslider()
