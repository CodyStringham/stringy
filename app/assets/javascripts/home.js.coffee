# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  fixNav = $('#fixed-nav')
  topJump = $('.top-jump')
  mobList = $('.mobile-nav-list')
  mobNav = $('.mobile-nav')

  wideScreen = false
  screenOffset = false

  getWidth = ->
    pageWidth = $(window).width()

  getOffset = ->
    pageOffset = window.pageYOffset

  checkScrollTop = (offset) ->
    if offset > 550 && screenOffset == false
      screenOffset = true
      topJump.fadeIn()

    if offset < 550 && screenOffset == true
      screenOffset = false
      topJump.fadeOut()

  checkWideScreen = (width) ->
    if width > 641 && wideScreen == false
      wideScreen = true

    if width < 641 && wideScreen == true
      wideScreen = false  

    if wideScreen == true && screenOffset == true
      fixNav.fadeIn()
    else
      fixNav.fadeOut()

 
  timer = undefined
  $(window).scroll ->
    window.clearTimeout timer if timer
    timer = window.setTimeout(->
      
      # actual callback
      checkScrollTop(getOffset())
      checkWideScreen(getWidth())
      mobNav.removeClass("expanded")
      
    , 25)
    return

  $(window).resize ->
    window.clearTimeout timer if timer
    timer = window.setTimeout(->
      
      # actual callback
      checkWideScreen(getWidth())
      
    , 100)
    return
    

  slideScroll = (element, navheight) ->
    root = $("body,html")
    offset = element.offset()
    offsetTop = offset.top
    totalScroll = offsetTop - navheight
    root.animate
      scrollTop: totalScroll
    , 800

  scrollMaster = (element, mod) ->
    el = $(element).attr("href")
    elWrap = $(el)
    slideScroll elWrap, mod
    false

  topJump.on "click", ->
    scrollMaster($(this), 45)

  mobList.on "click", "a", ->
    scrollMaster($(this), 200)

