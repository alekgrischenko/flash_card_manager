class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @card = current_user.pending_cards.first if current_user
  end
  
end
 
