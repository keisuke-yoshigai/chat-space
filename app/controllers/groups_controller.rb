class GroupsController < ApplicationController
  before_action :group_find, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(strong_parameter)
    if @group.save
      redirect_to controller: :messages, action: :index
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @group.update(strong_parameter)
    if @group.save
      redirect_to group_messages_path(params[:id])
    else
      render "edit"
    end
  end

  private

  def group_find
    @group = Group.find(params[:id])
  end

  def strong_parameter
    params.require(:group).permit(:name)
  end
end
