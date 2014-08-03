class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      redirect_back_or_to(root_path, success: 'User was successfully created')
    else
      render 'new'
    end
  end

  def edit
    current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
