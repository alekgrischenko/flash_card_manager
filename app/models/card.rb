class Card < ActiveRecord::Base

  validates :original_text, :translated_text, presence: true 

end
