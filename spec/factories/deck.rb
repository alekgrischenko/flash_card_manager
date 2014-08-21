FactoryGirl.define do
  factory :deck do
    title "deck"
    user_id "1"
  end

  factory :deck_with_cards, class: Deck do |f|
    f.title 'deck'
    f.user_id '1'
    f.after(:create) do |deck| 
      5.times do
        deck.cards << FactoryGirl.create(:card, original_text: "text", translated_text: "текст",
                                                review_date: Time.now - 1.day, user_id: deck.user_id, deck_id: deck.id)
      end
    end
  end
end
