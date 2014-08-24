class ReviewController < ApplicationController

  def check_translation
    card = Card.find(params[:card_id])
    if card.check(params[:translation])
      card.correct_answer
      flash[:success] = "Правильно"
    else
      card.incorrect_answer
      flash[:danger] = "Не правильно"
    end
    redirect_to root_path
  end

end

