$(document).on('turbolinks:load page:change', function() {
  var $scrollTarget = $(".main__chat:last");
  var $main = $(".main__chat");

  function createHtml(data) {
    var user_name = "<div class='main__chat__message__user-name'>" + data.user_name + "</div>";
    var created_at = "<div class='main__chat__message__send-time'>" + data.created_at + "</div>";
    var body = "<div class='main__chat__message__text'>" + data.body + "</div>";
    var image_url = "<div class='main__chat__message__image'><img src=" + data.image.url + "></div>";

    chatMessage = "<div class='main__chat__message'>" + user_name + created_at + body + "</div>";

    if (data.image.url) {
      chatMessage = "<div class='main__chat__message'>" + user_name + created_at + body + image_url +  "</div>";
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

    $scrollTarget.animate( {
        scrollTop: $scrollTarget[0].scrollHeight
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
        $main.append(html);
        $(".js-form")[0].reset();
        resetSendButton();
    })
    .fail(function() {
        alert("エラーが発生しました");
        resetSendButton();
    });
  });

  function automaticUpdate() {
    $.ajax( {
      type: "GET",
      url: document.location.href,
      dataType: "json",
    })
    .done(function(messages) {
      $main.empty();
      $.each(messages, function(index, message) {
        var html = createHtml(message);
        $main.append(html);
      });
      $scrollTarget.animate( {
          scrollTop: $scrollTarget[0].scrollHeight }, 500);
    })
    .fail(function(){
      alert("更新に失敗しました");
    });
  };
  setInterval(automaticUpdate, 5000);
});
