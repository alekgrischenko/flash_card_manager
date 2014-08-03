class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :correct_user,    only: [:edit, :update]

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
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

  def correct_user
    @user = User.find(params[:id])
  end

end
