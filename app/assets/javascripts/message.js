$(document).on('turbolinks:load page:change', function(){
  var scrollTarget = $(".main__chat:last");

  function createHtml(data) {
    var chatMessage = $(".main__chat__message");
    chatMessage.append("<div class='main__chat__message__user-name'>" + data.user_name + "</div>", "<div class='main__chat__message__send-time'>" + data.created_at + "</div>", "<div class='main__chat__message__text'>" + data.body + "</div>");

    if (data.image.url) {
        chatMessage.append("<div class='main__chat__message__image'><img src=" + data.image.url + "></div>");
    }
    return chatMessage;
  }

  function resetSendButton() {
    $(".main__footer__message-form__submit--back-blue").prop('disabled', false);
  }

  $(".js-form").on("submit",function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = location.href;

    scrollTarget.animate( {
        scrollTop: scrollTarget[0].scrollHeight
    }, 500);
    $.ajax( {
      type: "POST",
      url: url,
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data) {
        var html = createHtml(data);
        $(".main__chat").append(html);
        $(".main__footer__message-form__text").val("");
        $("#message_image").val("");
        resetSendButton();
    })
    .fail(function() {
        alert("エラーが発生しました");
        resetSendButton();
    });
  });

  function automaticUpdate(){
    $.ajax({
      type: "GET",
      url: document.location.href,
      dataType: "json",
    })
    .done(function(messages){
      $(".main__chat__message").remove();
      $.each(messages, function(index, message){
        createHtml(message);

        scrollTarget.animate( {
          scrollTop: scrollTarget[0].scrollHeight
        }, 0);
      });
      console.log("更新されました");
    })
    .fail(function(){
      alert("更新に失敗しました");
    });
  };
  setInterval(automaticUpdate, 5000);
});
