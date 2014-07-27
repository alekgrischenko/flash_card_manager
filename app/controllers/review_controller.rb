class ReviewController < ApplicationController

  def check_translation
    card = Card.find(params[:card_id])
    if card.check(params[:translation])
      card.update_review_date
      flash[:success] = "Правильно"
    else
      flash[:danger] = "Не правильно"
    end
    redirect_to root_path
  end

end

