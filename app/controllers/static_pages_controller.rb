class StaticPagesController < ApplicationController

  def index
    @card = Card.pending.first
  end
  
end
