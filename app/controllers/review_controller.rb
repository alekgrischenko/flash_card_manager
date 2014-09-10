class ReviewController < ApplicationController

  def check_translation
    @card = Card.find(params[:card_id])
    case @card.check(params[:translation]) 
    when :success
      flash[:success] = "Верно"
      session[:typo_count] = 0
      redirect_to root_path
    when :typo
      if session[:typo_count] < 3
        flash[:notice] = "Вы допустили опечатку"
        session[:typo_count] += 1
        redirect_to root_path(card_id: @card.id)
      else 
        flash[:danger] = "Вы допустили опечатку более 3 раз"
        session[:typo_count] = 0
        redirect_to root_path
      end
    else 
      flash[:danger] = "Не правильно"
      session[:typo_count] = 0
      redirect_to root_path
    end
  end

end

