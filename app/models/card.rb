class Card < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck

  validates :original_text, :translated_text, :user_id, :deck_id, presence: true 
  
  scope :pending, -> { where("review_date <= ?", Time.now).order("RANDOM()") } 
  
  mount_uploader :image, ImageUploader

  def check(translation)
    translation == translated_text ? correct_answer : incorrect_answer
  end

  def update_review_date
    case numb_correct_answers
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
    else
      update_attribute(:numb_correct_answers, 5)
      update_attribute(:review_date, (Time.now + 1.month))
    end
  end

  def correct_answer
    increment(:numb_correct_answers)
    update_attribute(:numb_incorrect_answers, 0)
    update_review_date
    return true
  end

  def incorrect_answer
    if numb_incorrect_answers < 3
      increment(:numb_incorrect_answers)
    else
      decrement(:numb_correct_answers) if numb_correct_answers > 0
      update_attribute(:numb_incorrect_answers, 0)
      update_review_date
    end
    return false
  end

end
