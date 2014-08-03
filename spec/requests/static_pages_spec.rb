require 'rails_helper'

describe "Static page" do

  describe "Home page" do
    let(:user) {FactoryGirl.create(:user)}
    

    describe "when review date less current" do

      before(:each) do 
        FactoryGirl.create(:card, original_text: "text", translated_text: "текст", review_date: Time.now - 1.day )
        sign_in user
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

    describe "when rewiew date more than today" do
      before(:each) do
        FactoryGirl.create(:card, review_date: Time.now + 1.day )
        sign_in user
      end

      it { expect(page).to have_content "Приходите завтра" }
    end
  end
end
