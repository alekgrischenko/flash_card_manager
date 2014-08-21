require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  describe "pending_cards" do
      
    before(:each) do
      5.times { FactoryGirl.create(:deck_with_cards, user_id: user.id) }
    end

    it "user have current deck" do
      user.update_attribute(:current_deck_id, user.decks.sample.id)
      expect(user.pending_cards.sample.deck_id).to eq user.current_deck_id
    end

    it "user not have current deck" do
      expect(user.pending_cards.sample.user_id).to eq user.id
    end
  end
end
