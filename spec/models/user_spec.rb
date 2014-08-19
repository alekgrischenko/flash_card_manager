require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  describe "pending_cards" do
      
    before(:each) do
      5.times { FactoryGirl.create(:deck_with_cards, user_id: user.id) }
      user.update_attribute(:current_deck_id, user.decks.sample.id)
    end

    it { expect(user.pending_cards.first.deck_id).to eq user.current_deck_id }
  end
end
