class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    if current_user
      if current_user.cards.first
        @card = current_user.pending_cards.first
      elsif current_user.decks.empty?
        redirect_back_or_to(:new_deck, warning: 'Необходимо создать колоду и добавить туда карточки.')
      else
        redirect_back_or_to(:decks, warning: 'Необходимо добавить карточки в колоду.')
      end
    end
  end
  
end
 
