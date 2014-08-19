class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
=begin
    if current_user.try(:current_deck)
      @card = current_user.current_deck.cards.pending.first 
    elsif current_user
      @card = current_user.cards.pending.first
    end
=end
    @card = current_user.pending_cards.first if current_user
  end
  
end
 
