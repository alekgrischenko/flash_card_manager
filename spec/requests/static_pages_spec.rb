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
      it { expect(page).to have_link("Колоды",        href: decks_path) }
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
          let!(:card) { FactoryGirl.create(:card, user_id: user.id, deck_id: deck.id)  }

          before(:each) do
            card.update_attributes(review_date: (Time.now + 1.day))
            visit root_path
          end

          it { expect(page).to have_content "На сегодня все карточки закончились. Приходите завтра." }
        end

        describe "user have decks and cards and review date less then today" do
          let!(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", user_id: user.id, deck_id: deck.id) }

          before(:each) do
            visit root_path
          end

          it { expect(page).to have_content card.original_text }

          describe "when input translation" do

            describe "and translate right" do

             before(:each) do
                fill_in 'translation', with: "текст"
                click_button "Проверка"
              end

              it { expect(page).to have_content "Верно" }

              it "change numb_correct_answers" do
                card.reload
                expect(card.numb_correct_answers).to eq 1
              end
            end

            describe "and translate wrong" do

             before(:each) do
                fill_in 'translation', with: ""
                click_button "Проверка"
              end

              it { expect(page).to have_content "Не правильно" }

              it "change numb_incorrect_answers" do
                card.reload
                expect(card.numb_incorrect_answers).to eq 1
              end
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

      it { expect(page).to have_content user.current_deck.title }
    end
  end
end
