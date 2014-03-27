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
      topJump.fadeIn()

    if offset < 550 && screenOffset == true
      screenOffset = false
      topJump.fadeOut()

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
    scrollMaster( $(this), 200 )
    mobNav.removeClass("expanded")

