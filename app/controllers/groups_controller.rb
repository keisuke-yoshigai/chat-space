class GroupsController < ApplicationController
  before_action :group_find, only: [:edit, :update]

  def new
    @group = Group.new
    render "new_edit"
  end

  def create
    @group = Group.create(strong_parameter)
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to controller: :messages, action: :index
    else
      flash[:alert] = "グループを作成できませんでした"
      render "new_edit"
    end
  end

  def edit
    render "new_edit"
  end

  def update
    @group.update(strong_parameter)
    if @group.save
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
