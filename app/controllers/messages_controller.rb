class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    # .includes(group_users: :user)
    @message = Message.new
  end

  def new
  end

  def create
    @message = Message.create(message_params)
    redirect_to group_messages_path(params[:group_id])
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end
end
