if !window.spurs then window.spurs = {}

window.spurs.flashes =
  highest_priority_flash_container: ->
    highest = -100
    highest_item = null
    $("." + spurs.vars.flashes.container_class).each (idx, item) ->
      priority = parseInt($(item).attr("id").substring($("." + spurs.vars.flashes.container_class).attr("id").indexOf(spurs.vars.flashes.container_id_prefix) + spurs.vars.flashes.container_id_prefix.length))
      if priority > highest
        highest = priority
        highest_item = $(item)
    highest_item

  lowest_priority_flash_container: ->
      lowest = 9999
      lowest_item = null
      $("." + spurs.vars.flashes.container_class).each (idx, item) ->
        priority = parseInt($(item).attr("id").substring($("." + spurs.vars.flashes.container_class).attr("id").indexOf(spurs.vars.flashes.container_id_prefix) + spurs.vars.flashes.container_id_prefix.length))
        if priority < lowest
          lowest = priority
          lowest_item = $(item)
      lowest_item

  alert: (message, flavor) ->
    $.ajax
      url: spurs.vars.flashes.create_path + ".js"
      type: "POST"
      data:
        message: message
        flavor: flavor