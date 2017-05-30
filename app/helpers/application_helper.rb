module ApplicationHelper
  def new_or_edit_add
    if current_page?(controller: "groups", action: "new")
      content_tag(:h1, "新規チャットグループ")
    else
      content_tag(:h1, "チャットグループ編集")
    end
  end
end
