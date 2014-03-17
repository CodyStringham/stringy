# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  fixNav = $('#fixed-nav')
  topJump = $('.top-jump')
  mobList = $('.mobile-nav-list')
  mobNav = $('.mobile-nav')

  checkWidth = () ->
    if $(window).width() > 641 && window.pageYOffset > 550
      fixNav.fadeIn()
    else
      fixNav.fadeOut()

  checkWidth()

  checkScroll = (ev) ->
    if window.pageYOffset > 550
      topJump.fadeIn()
    else
      topJump.fadeOut()

  window.onresize =  ->
    checkWidth()

  window.onscroll = ->
    checkScroll()
    checkWidth()
    mobNav.removeClass("expanded")

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

