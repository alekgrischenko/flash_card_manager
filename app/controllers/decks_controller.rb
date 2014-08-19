class DecksController < ApplicationController

  before_action :find_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def show
  end

  def create
    @deck = current_user.decks.create(deck_params)

    if @deck.save
      redirect_to decks_path(current_user.id)
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

    redirect_to decks_path(current_user.id)
  end

  private
  
  def deck_params
    params.require(:deck).permit(:title)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

end
