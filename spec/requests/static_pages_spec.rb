require 'rails_helper'

describe "Static page" do 

  subject { page }

  describe "Home page" do

    describe "when review date less than current date" do
      #let(:card) { FactoryGirl.create(:card) }
      
      it "should output word in English" do
        card = Card.create(original_text:"text", translated_text:"текст", review_date:"12/07/2014")
        visit root_path
        binding.pry
        page.save_screenshot("tmp/capybara/page.png")
        should have_content(card.original_text) 
      end
    end
  end
end
