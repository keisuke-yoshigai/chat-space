class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      user.update(strong_parameter)
    end
    redirect_to controller: :messages, action: :index
  end

  private
  def strong_parameter
    params.require(:user).permit(:name, :email)
  end
end
