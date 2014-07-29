require 'rails_helper'

describe Card do

  before { @card = Card.new(original_text: "door", translated_text: "дверь", review_date: "25-07-2014") }

  describe "check translation" do
    it "should check wrong translation" do
      expect(@card.check("что-то")).to be false
    end

    it "should check right translation" do
      expect(@card.check("дверь")).to be true
    end
  end


  it "should update review_date" do
    t = Time.parse("21/07/2013")
    allow(Time).to receive(:now) { t }
    @card.update_review_date
    expect(@card.review_date).to eq (Time.now + 3.day)
  end

end
