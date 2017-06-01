class MessagesController < ApplicationController
  before_action :find_group, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(params[:group_id]), notice: "メッセージを作成しました"
    else
      flash.now[:alert] = "メッセージ作成に失敗しました"
      render "index"
    end
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end
end
