class ReviewController < ApplicationController

  def check_translation
    @card = Card.find(params[:card_id])
   # @translation = params[:translation]
    case @card.check(params[:translation]) 
    when 1
      flash[:success] = "Верно"
      redirect_to root_path
    when 2
      flash[:notice] = "Вы допустили опечатку"
      render "static_pages/typo"
    else 
      flash[:danger] = "Не правильно"
      redirect_to root_path
    end
  end

end

