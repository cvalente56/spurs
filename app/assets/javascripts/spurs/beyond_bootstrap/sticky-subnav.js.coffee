not ($) ->
  $ ->
    processScroll = ->
      i = undefined
      scrollTop = $win.scrollTop()
      if scrollTop >= navTop and not isFixed
        isFixed = 1
        $nav.addClass "subnav-fixed"
      else if scrollTop <= navTop and isFixed
        isFixed = 0
        $nav.removeClass "subnav-fixed"
    $win = $(window)
    $nav = $(".subnav")
    navTop = $(".subnav").length and $(".subnav").offset().top - 40
    isFixed = 0
    processScroll()
    $nav.on "click", ->
      unless isFixed
        setTimeout (->
          $win.scrollTop $win.scrollTop() - 47
        ), 10

    $win.on "scroll", processScroll
(window.jQuery)