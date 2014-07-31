require 'rails_helper'

describe "Static page" do
  
  it "Home page have original word when rewiew date less than today" do
    card = FactoryGirl.create(:card, original_text: "text", review_date:"30/07/2014")
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "Home page warning when rewiew date more than today" do
    FactoryGirl.create(:card, review_date:"#{Time.now+1.day}")
    visit root_path
    expect(page).to have_content "Приходите завтра"
  end

  it "Message when translate wrong" do
    FactoryGirl.create(:card)
    visit root_path
    click_button "Проверка"
    expect(page).to have_content "Не правильно"
  end

  it "Message when translate right" do
    FactoryGirl.create(:card)
    visit root_path
    fill_in 'translation', with: "текст"
    click_button "Проверка"
    expect(page).to have_content "Правильно"
  end
end
