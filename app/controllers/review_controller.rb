class ReviewController < ApplicationController

  def check_translation
    @card = current_user.cards.find(params[:card_id])
    reset_typo_count if !session[:typo_count]
    case @card.check(params[:translation], session[:typo_count], params[:time])
    when :success
      reset_typo_count
      respond_to do |format|
        format.html { redirect_to root_path, success: "Верно"}
        format.json { render json: {success: "Верно"}}
      end
    when :typo
      respond_to do |format|
        if (session[:typo_count] < 3)
          session[:typo_count] += 1
          format.html { redirect_to root_path(card_id: @card.id),
                        notice: "Вы допустили опечатку. Количество оставшихся попыток: #{3 - session[:typo_count]}" }
          format.json { render json: {notice: "Вы допустили опечатку. Количество оставшихся попыток: #{3 - session[:typo_count]}"} }
        else
          reset_typo_count
          @card.process_incorrect_answer
          format.html { redirect_to root_path, danger: "Вы допустили опечатку более 3 раз" }
          format.json { render json: { danger: "Вы допустили опечатку более 3 раз" }}
        end
      end
    else
      reset_typo_count
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Не правильно" }
        format.json { render json: { alert: "Не правильно" }}
      end
    end
  end

  private

  def reset_typo_count
    session[:typo_count] = 0
  end

end

