if !window.spurs then window.spurs = {}

window.spurs.sections = toggle: (section) ->
  if section.hasClass("open")
    section.removeClass "open"
    section.find(".section_toggle").html "<i class=\"icon-chevron-right\"></i>"
  else
    section.addClass "open"
    section.find(".section_toggle").html "<i class=\"icon-chevron-down\"></i>"