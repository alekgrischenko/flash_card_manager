class ReviewController < ApplicationController

  def check_translation
    @card = Card.find(params[:card_id])
    case @card.check(params[:translation]) 
    when :success
      flash[:success] = "Верно"
      redirect_to root_path
    when :typo
      if session[:typo_count] < 3
        flash[:notice] = "Вы допустили опечатку"
        session[:typo_count] += 1
        render "static_pages/index"
      else 
        flash[:danger] = "Вы допустили опечатку более 3 раз"
        session[:typo_count] = 0
        redirect_to root_path
      end
    else 
      flash[:danger] = "Не правильно"
      redirect_to root_path
    end
  end

end

