FactoryGirl.define do
  factory :card do
    original_text "text"
    translated_text "текст"
    review_date { Time.parse("21/07/2014 18:15:11") }
    user_id "1"
    deck_id "1"
  end
end
