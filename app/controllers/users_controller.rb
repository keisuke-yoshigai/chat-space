class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.search params[:keyword]
    respond_to do |format|
      format.json
    end
  end

  def edit
  end

  def update
    @user.update(user_parameter)

    if @user.save
      redirect_to root_path
    else
      redirect_to edit_user_path(current_user.id)
    end
  end

  private

  def user_parameter
    params.require(:user).permit(:name, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
