class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    # .includes(group_users: :user)
    @message = Message.new
  end

  def new
  end

  def create
    @group = Group.find(params[:group_id])
    @message = @group.messages.new(message_params)
    if @message.save
      flash[:notice] = "メッセージを作成しました"
      redirect_to group_messages_path(params[:group_id])
    else
      flash.now[:alert] = "メッセージ作成に失敗しました"
      render "index"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end
end
