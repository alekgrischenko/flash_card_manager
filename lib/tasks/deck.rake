namespace :deck do
  desc "Create a deck and place in it existing cards"
  task create: :environment do
    for user in User.all 
      if user.decks.empty?
        deck = Deck.create(title: "deck for user #{user.email}", user_id: user.id) if user.cards.any?
        user.cards.each do |card|
          card.update_attribute(:deck_id, deck.id)
        end
      end
    end
  end
end
