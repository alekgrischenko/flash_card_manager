class Card < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck

  validates :original_text, :translated_text, :user_id, :deck_id, presence: true 
  
  scope :pending, -> { where("review_date <= ?", Time.now).order("RANDOM()") } 
  
  mount_uploader :image, ImageUploader

  before_create :set_default_review_date

  def check(translation, typo_count, time_factor)
    case Levenshtein.distance(translated_text, translation) 
    when 0
      process_correct_answer(typo_count, time_factor)
      :success
    when 1..3
      :typo
    else
      process_incorrect_answer
      :error
    end
  end

  def process_correct_answer(typo_count, time_factor)
    increment(:numb_correct_answers)
    update_card_attributes(typo_count, time_factor)
  end

  def process_incorrect_answer
    if numb_incorrect_answers < 3
      increment(:numb_incorrect_answers)
      save
    else
      reset_card_attributes
    end
  end

  def update_card_attributes(typo_count, time_factor)
    update_attribute(:ef, SuperMemo.new(interval, ef, numb_correct_answers).calculate_e_factor(typo_count, time_factor)) if typo_count <= 1
    update_attribute(:interval, SuperMemo.new(interval, ef, numb_correct_answers).calculate_new_interval(typo_count, time_factor))
    update_attributes(review_date: (Time.now + interval.day), numb_incorrect_answers: 0)
  end  
  
  def reset_card_attributes
    update_attributes(numb_correct_answers: 0, numb_incorrect_answers: 0, ef: 1.3, interval: 1, review_date: Time.now)
  end

  def set_default_review_date
    self.review_date = Time.now
  end

end
