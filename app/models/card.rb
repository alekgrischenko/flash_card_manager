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
    case numb_correct_answers.to_i
    when 0 
      update_attribute(:review_date, Time.now)
    when 1
      update_attribute(:review_date, (Time.now + 12.hour))
    when 2
      update_attribute(:review_date, (Time.now + 3.day))
    when 3
      update_attribute(:review_date, (Time.now + 1.week)) 
    when 4
      update_attribute(:review_date, (Time.now + 2.week)) 
    when 5
      update_attribute(:review_date, (Time.now + 1.month))
    end
  end

  def correct_answer
    increment(:numb_correct_answers, 1) if numb_correct_answers.to_i < 5
    update_attribute(:numb_incorrect_answers, nil)
    update_review_date
  end

  def incorrect_answer
    if numb_incorrect_answers.to_i < 3
      increment(:numb_incorrect_answers, 1)
    else
      decrement(:numb_correct_answers, 1) if numb_correct_answers.to_i > 0
      update_attribute(:numb_incorrect_answers, nil)
      update_review_date
    end
  end

end
