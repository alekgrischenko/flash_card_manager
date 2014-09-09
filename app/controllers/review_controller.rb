class ReviewController < ApplicationController

  def check_translation
    @card = Card.find(params[:card_id])
    case @card.check(params[:translation]) 
    when 1
      flash[:success] = "Верно"
      redirect_to root_path
    when 2
      if session[:typo_count] < 3
        flash[:notice] = "Вы допустили опечатку"
        render "static_pages/index"
        session[:typo_count] += 1
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

