class CardsController < ApplicationController

  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :find_deck, only: [:index, :new, :create]

  def index
    @cards = @deck.cards
  end

  def new
    @card = @deck.cards.new
  end
   
  def create
    @card = @deck.cards.create(card_params.merge(user_id: current_user.id))
   
    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update

    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end

  end

  def destroy
    @card.destroy
    
    redirect_to deck_cards_path(@card.deck_id)    
  end
   
  private
  
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end

  def find_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

end
