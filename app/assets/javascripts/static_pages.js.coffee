$(".static_pages.index").ready ->
  start_time = new Date()
  $("form").submit (event) ->
    event.preventDefault()
    delta = new Date() - start_time
    $.post "/check_translation.json",
      translation: $("input[name=translation]").val()
      card_id: $("input[name=card_id]").val()
      time: delta
      authenticity_token: $("input[name=authenticity_token]").val()
      _method: "put"
      commit: "Проверка"
    , (data) ->
      $.get "/", data, ((data) ->
        alert data
        $(".card_review").html data
        return
      ), "script"
      return
