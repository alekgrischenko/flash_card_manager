class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    if current_user && current_user.current_deck
      @card = current_user.current_deck.cards.pending.first 
    elsif current_user
      @card = current_user.cards.pending.first
    end
  end
  
end
