class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(strong_parameter)
    if @user.save
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  private
  def strong_parameter
    params.require(:user).permit(:name, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
