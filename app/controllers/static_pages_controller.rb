class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :current_user?

  def index
    if params[:card_id]
      @card = current_user.cards.find(params[:card_id])
    elsif current_user.cards.first
      @card = current_user.pending_cards.first
    elsif current_user.decks.empty?
      redirect_to :new_deck, notice: 'Необходимо создать колоду и добавить туда карточки.'
    else
      redirect_to :decks, notice: 'Необходимо добавить карточки в колоду.'
    end
  end

  def current_user?
    if !current_user
      flash[:notice] = "Войдите или зарегистрируйтесь"
      redirect_to new_user_path
    end
  end
  
end
 
