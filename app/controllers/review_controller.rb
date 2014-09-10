class ReviewController < ApplicationController

  def check_translation
    @card = Card.find(params[:card_id])
    reset_typo_count if !session[:typo_count]
    case @card.check(params[:translation]) 
    when :success
      success_action
    when :typo
      typo_action
    else 
      error_action
    end
  end

  def success_action
    flash[:success] = "Верно"
    reset_typo_count
    redirect_to root_path
  end

  def typo_action
    if (session[:typo_count] < 3)
      increment_typo_count
    else 
      to_many_typos
    end
  end

  def error_action
    flash[:danger] = "Не правильно"
    reset_typo_count
    redirect_to root_path
  end

  def increment_typo_count
    flash[:notice] = "Вы допустили опечатку. Количество оставшихся попыток: #{3 - session[:typo_count]}"
    session[:typo_count] += 1
    redirect_to root_path(card_id: @card.id)
  end

  def to_many_typos
    flash[:danger] = "Вы допустили опечатку более 3 раз"
    reset_typo_count
    redirect_to root_path
  end

  def reset_typo_count
    session[:typo_count] = 0
  end

end

