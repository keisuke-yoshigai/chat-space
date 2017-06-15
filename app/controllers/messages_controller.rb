class MessagesController < ApplicationController
  before_action :find_group, only: [:index, :create]
  before_action :group_messages, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = @group.messages.new(message_params)

    if @message.save
      respond_to do |format|
        format.html {
         redirect_to group_messages_path(params[:group_id]), notice: "メッセージを作成しました"
        }
        format.json {
          render "index", handlers: "jbuilder"
        }
      end
    else
      flash.now[:alert] = "メッセージ作成に失敗しました"
      render "index"
    end
  end

  private

  def find_group
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def group_messages
    @messages = @group.messages.includes(:user).order("created_at ASC") if params[:group_id]
  end
end
