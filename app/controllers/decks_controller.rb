class DecksController < ApplicationController

  before_action :find_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.new
  end

  def show
    redirect_to deck_cards_path(@deck)
  end

  def create
    @deck = current_user.decks.create(deck_params)

    if @deck.save
      redirect_to decks_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    @deck.destroy

    redirect_to decks_path
  end

  private
  
  def deck_params
    params.require(:deck).permit(:title)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

end
