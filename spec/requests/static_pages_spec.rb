require 'rails_helper'

describe "Static page" do 

  describe "Home page" do

    describe "when review date less than current date" do
      
      let(:card) { FactoryGirl.create(:card, original_text:"text", translated_text:"bar", review_date:"12/07/2014") }
      before(:all) { visit root_path }

      it "should output word in English " do
        expect(page).to have_content(card.original_text) 
      end

=begin
      describe "should have text field and button" do
       
        it { expect(page).to have_selector('input#translation[name="translation"]') }
        it { expect(page).to have_selector('input[type="submit"]') }
      end
=end


    end

    describe "when review date more than current date" do
     
      let(:card) { FactoryGirl.create(:card, original_text:"text", translated_text:"bar", review_date: "02/08/2014" ) }
      before(:all) { visit root_path }

      it { 
        page.save_screenshot("tmp/capybara/page.png")
        #binding.pry
        expect(page).to have_selector('div.alert.alert-warning')}
    end
  end
end
