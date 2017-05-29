class GroupsController < ApplicationController
  before_action :group_find, only: [:edit, :update]

  def new
    @group = Group.new
    render "new"
  end

  def create
    @group = Group.new(strong_parameter)
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to controller: :messages, action: :index
    else
      flash[:alert] = "グループを作成できませんでした"
      render "new"
    end
  end

  def edit
    render "edit"
  end

  def update
    if @group.update(strong_parameter)
      flash[:notice] = "グループを編集しました"
      redirect_to group_messages_path(params[:id])
    else
      flash[:alert] = "グループを編集できませんでした"
      redirect_to action: :edit
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
