class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      auto_login(@user)
      redirect_back_or_to(new_deck_path, success: 'User was successfully created')
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

  def set_current_deck
    current_user.update_attribute(:current_deck_id, params[:id])
    redirect_back_or_to(decks_path, success: 'Current deck set')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
