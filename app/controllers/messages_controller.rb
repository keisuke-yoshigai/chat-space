class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id]).includes(group_user: :users)
  end
end
