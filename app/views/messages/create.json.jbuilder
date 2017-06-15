json.set! :user_name, @message.user.name
json.set! :created_at, @message.created_at.strftime("%Y/%m/%d %H:%M:%S")
json.set! :body, @message.body
json.set! :image, @message.image
