$('.static_pages.index').ready ->
  start_time = new Date()
  $('form').submit ->
    delta = new Date() - start_time
    $('input[name="time"]').val(delta)
