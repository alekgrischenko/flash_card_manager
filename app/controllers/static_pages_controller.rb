class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @card = current_user.cards.pending.first if current_user
  end
  
end
