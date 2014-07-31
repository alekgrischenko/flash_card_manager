require 'rails_helper'

describe "Static page" do

  describe "Home page" do

    describe "when review date less current" do

      before(:each) do 
        FactoryGirl.create(:card)
        visit root_path
      end
     
      it { expect(page).to have_content "text" }

      describe "when input translation" do

        it "message when translate wrong" do
          fill_in 'translation', with: ""
          click_button "Проверка"
          expect(page).to have_content "Не правильно"
        end

        it "message when translate right" do
          fill_in 'translation', with: "текст"
          click_button "Проверка"
          expect(page).to have_content "Правильно"
        end
      end
    end

    it "Home page warning when rewiew date more than today" do
      FactoryGirl.create(:card, review_date:"#{Time.now+1.day}")
      visit root_path
      expect(page).to have_content "Приходите завтра"
    end
  end
end
