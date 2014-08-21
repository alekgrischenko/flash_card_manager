class Deck < ActiveRecord::Base

  belongs_to :user
  
  has_many :cards, dependent: :destroy

  validates :title, :user_id, presence: true 

  after_destroy do |deck|
    user = User.where("current_deck_id = ?", deck.id).first
    user.update_attribute(:current_deck_id, nil) if user
  end

end
