require 'rails_helper'

describe "Static page" do
  
  it "does stuf" do
    FactoryGirl.create(:card, original_text: "bla bla")
    visit root_path
    expect(page).to have_content "bla bla"
  end
  
end
