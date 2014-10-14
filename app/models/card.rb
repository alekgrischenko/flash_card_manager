class Card < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck

  validates :original_text, :translated_text, :user_id, :deck_id, presence: true 
  
  scope :pending, -> { where("review_date <= ?", Time.now).order("RANDOM()") } 
  
  mount_uploader :image, ImageUploader

  before_create :set_default_review_date

  def check(translation, typo_count, time)
    case Levenshtein.distance(translated_text, translation) 
    when 0
      process_correct_answer(typo_count, time)
      :success
    when 1..3
      :typo
    else
      process_incorrect_answer
      :error
    end
  end

  def process_correct_answer(typo_count, time)
    increment(:numb_correct_answers)
    renew_attributes(typo_count, time)
  end

  def process_incorrect_answer
    if numb_incorrect_answers < 3
      increment(:numb_incorrect_answers)
      save
    else
      reset_attributes
    end
  end

  def renew_attributes(typo_count, time)
    supermemo = SuperMemo.new(interval, ef, typo_count, time, translated_text.length, numb_correct_answers)
    new_ef = supermemo.e_factor
    new_interval = supermemo.interval
    new_review_date = Time.now + new_interval.day
    update_attributes(ef: new_ef, interval: new_interval, review_date: new_review_date, numb_incorrect_answers: 0) 
  end  
  
  def reset_attributes
    update_attributes(numb_correct_answers: 0, numb_incorrect_answers: 0, ef: 1.3, interval: 1, review_date: Time.now)
  end

  def set_default_review_date
    self.review_date = Time.now
  end

end
