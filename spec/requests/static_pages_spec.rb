require 'rails_helper'

describe "Static page" do

  describe "Home page" do

    describe "when user no login" do

      before(:each) {visit root_path}

      it { expect(page).to have_link("Войти",       href: login_path) }
      it { expect(page).to have_link("Регистрация", href: new_user_path) }
    end

    describe "when user login" do
      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        sign_in user
        visit root_path
      end
      
      it { expect(page).to have_link("Редактировать", href: edit_user_path(user.id)) }
      it { expect(page).to have_link("Выйти",         href: logout_path) }
      it { expect(page).to have_link("Колоды",        href: decks_path(user.id)) }
      it { expect(page).to have_content user.email }

      describe "when user have not decks and cards" do
        it { expect(page).to have_content "Необходимо создать колоду и добавить туда карточки."}
      end

      describe "and user have decks but not have cards" do
        let!(:deck) { FactoryGirl.create(:deck, user_id: user.id) }
        
        before(:each) do
          visit root_path
        end
      
        it { expect(page).to have_content "Необходимо добавить карточки в колоду." }

        describe "user have decks and cards and review date more then today" do
          let!(:card) { FactoryGirl.create(:card, user_id: user.id, deck_id: deck.id, review_date: Time.now + 1.day) }

          before(:each) do
            visit root_path
          end
        
          it { expect(page).to have_content "На сегодня все карточки закончились. Приходите завтра." }
        end

        describe "user have decks and cards and review date less then today" do
          let!(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", user_id: user.id, deck_id: deck.id, review_date: Time.now - 1.day) }

          before(:each) do
            visit root_path
          end
        
          it { expect(page).to have_content card.original_text }

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
      end
    end

    describe "when user login and have several decks and cards" do
      let(:user) { FactoryGirl.create(:user) }
      
      before(:each) do
        sign_in user
        5.times { FactoryGirl.create(:deck_with_cards) }
        user.update_attribute(:current_deck_id, user.decks.sample.id)
        visit root_path
      end

      it { expect(user.pending_cards.first.deck_id).to eq user.current_deck_id }
    end
  end
end
