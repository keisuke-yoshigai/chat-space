class GroupsController < ApplicationController
  before_action :group_find, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to group_messages_path(@group.id)
    else
      flash.now[:alert] = "グループを作成できませんでした"
      render "new"
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループを編集しました"
      redirect_to group_messages_path(params[:id])
    else
      flash.now[:alert] = "グループを編集できませんでした"
      render "edit"
    end
  end

  private

  def group_find
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end
end
