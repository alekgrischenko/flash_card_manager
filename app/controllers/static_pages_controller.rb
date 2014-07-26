class StaticPagesController < ApplicationController

  def index
    @card = Card.pending_card.first
  end
  
end
