class ReviewController < ApplicationController

  def check_translation
    @card = current_user.cards.find(params[:card_id])
    reset_typo_count if !session[:typo_count]
    case @card.check(params[:translation], session[:typo_count], params[:time]) 
    when :success
      flash[:success] = "Верно"
      reset_typo_count
      redirect_to root_path
    when :typo
      if (session[:typo_count] < 3)
        flash[:notice] = "Вы допустили опечатку. Количество оставшихся попыток: #{3 - session[:typo_count]}"
        session[:typo_count] += 1
        redirect_to root_path(card_id: @card.id)
      else 
        flash[:danger] = "Вы допустили опечатку более 3 раз"
        reset_typo_count
        @card.process_incorrect_answer
        redirect_to root_path
      end
    else 
      flash[:danger] = "Не правильно"
      reset_typo_count
      redirect_to root_path
    end
  end

  private
  
  def reset_typo_count
    session[:typo_count] = 0
  end

end

