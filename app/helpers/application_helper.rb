module ApplicationHelper
  def new_or_edit_add
    if current_page?(controller: "groups", action: "new")
      content_tag(:h1, "新規チャットグループ")
    else
      content_tag(:h1, "チャットグループ編集")
    end
  end

  def message_check(group)
    if group.messages.empty?
      "まだメッセージはありません"
    elsif group.messages.last.body.present?
      group.messages.last.body
    else
      "画像が投稿されています"
    end
  end
end
