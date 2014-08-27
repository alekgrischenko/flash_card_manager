class Card < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck

  validates :original_text, :translated_text, :user_id, :deck_id, presence: true 
  
  scope :pending, -> { where("review_date <= ?", Time.now).order("RANDOM()") } 
  
  mount_uploader :image, ImageUploader

  before_create :set_default_review_date

  def check(translation)
    if translation == translated_text 
      process_correct_answer
      return true
    else
      process_incorrect_answer
      return false
    end
  end

  def update_review_date
    update_attribute(:review_date, calc_time_till_review)
  end

  def process_correct_answer
    increment(:numb_correct_answers)
    update_attribute(:numb_incorrect_answers, 0)
    update_review_date
  end

  def process_incorrect_answer
    if numb_incorrect_answers < 3
      increment(:numb_incorrect_answers)
      save
    else
      decrement(:numb_correct_answers) if numb_correct_answers > 0
      update_attribute(:numb_incorrect_answers, 0)
      update_review_date
    end
  end

  def calc_time_till_review
    case numb_correct_answers
    when 0 
      Time.now
    when 1
      Time.now + 12.hour
    when 2
      Time.now + 3.day
    when 3
      Time.now + 1.week 
    when 4
      Time.now + 2.week 
    else
      update_attribute(:numb_correct_answers, 5)
      Time.now + 1.month
    end
  end

  def set_default_review_date
    self.review_date = Time.now
  end
  
end
