App.room = App.cable.subscriptions.create {channel: "RoomChannel", room: $(".messages").attr("id")},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)
    if data["room"] != null
      console.log(data["room"])
      console.log("received in index")
      $("#"+data["room"]).css("color", "red")
      $(".flexbox-columns-start").prepend($("#"+data["room"]))
    else
      $('.messages').append data['message']
      console.log("received")
      $("#messages").scrollTop($("#messages")[0].scrollHeight)


  speak: (message, id) ->
    @perform 'speak', message: message, id: id

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    console.log(App.cable.subscriptions)
    App.room.speak event.target.value, $(".messages").attr("id"),
    event.target.value = ''
    event.preventDefault()


