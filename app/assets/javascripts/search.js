$(document).on('load turbolinks:load page:change', function() {
  function createHtml(user) {
    $("#user-search-result").append("<div class='chat-group-user chat-group-user-search clearfix'>");
    var targetUserInfo = $(".chat-group-user-search");
    $(targetUserInfo).append("<p class='chat-group-user__name'>" + user.name + "</p>");
    $(targetUserInfo).append($("<a class='user-search-add chat-group-user__btn chat-group-user__btn--add' data-user-id=" + user.id + " data-user-name=" + user.name + ">追加</a>"));
  }

  function addMember(id, name){
    var inputTag = "<input name='group[user_ids][]' type='hidden' value=" + id +  ">";
    var nameTag = "<p class=chat-group-user__name>" + name + "</p>";
    var aTag = "<a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>";

    $("#chat-group-users").append("<li class='chat-group-user chat-group-user-list clearfix'>" + inputTag + nameTag + aTag + "</li>");
  }

  function editElement(element) {
    var result = "^" + element;
    return result;
  }

  $(".chat-group-form__search").on("keyup", function(e){
    e.preventDefault();
    var preWord = "";
    var input = $("#user-search-field").val();
    var inputs = input.split(" ").filter(function(e) { return e; });
    var newInputs = inputs.map(editElement);
    var word = newInputs.join("|");
    var reg = RegExp(word);

    if (word != preWord || word.length==0) {
      $(".chat-group-user-search").remove();

      if(input.length !== 0) {
        $.ajax( {
          type: "GET",
          url: "/users",
          data: ("keyword=" + input),
          dataType: "json",
          processData: false,
          contentType: false
        })
        .done(function(data) {
          $.each(data, function(index, user){
            createHtml(user);
          })
        })
        .fail(function() {
          alert("通信に失敗");
        });
      }
    }
    word = preWord;
  });
  $("#user-search-result").on("click", ".user-search-add", function(){
      var id = $(this).attr("data-user-id");
      var name = $(this).attr("data-user-name");
      addMember(id, name);
      $(this).parent().remove();
  });
  $("#chat-group-users").on("click", ".js-remove-btn", function(){
    $(this).parent().remove();
  })
});
