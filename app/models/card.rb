class Card < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck

  validates :original_text, :translated_text, :user_id, :deck_id, presence: true 
  
  scope :pending, -> { where("review_date <= ?", Time.now).order("RANDOM()") } 
  
  mount_uploader :image, ImageUploader

  def check(translation)
    translation == translated_text
  end

  def update_review_date
    update_attribute(:review_date, (Time.now + 3.day))
  end

end
