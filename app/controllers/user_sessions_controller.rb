class UserSessionsController < ApplicationController

  skip_before_action :require_login, except: [:destroy]
  
  def new
  end
  
  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:root, success: 'Login successful')
    else
      flash.now[:danger] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_back_or_to(:root, success: 'Logget out!')
  end

end
