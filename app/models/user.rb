class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, confirmation: true  
  validates :password_confirmation, presence: true 
  validates :email, uniqueness: true 

  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  belongs_to :current_deck, class_name: "Deck", foreign_key: "current_deck_id"

  def pending_cards
    if current_deck_id
      current_deck.cards.pending
    else
      cards.pending
    end
  end

end
