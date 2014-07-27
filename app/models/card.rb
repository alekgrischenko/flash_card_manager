class Card < ActiveRecord::Base

  validates :original_text, :translated_text, presence: true 
  scope :pending_card, -> { where("review_date <= ? ", Time.now).order("RANDOM()") } 

  def check(translation)
    translation == translated_text
  end

  def update_review_date
    update_attribute(:review_date, (Time.now + 3.day))
  end

end
