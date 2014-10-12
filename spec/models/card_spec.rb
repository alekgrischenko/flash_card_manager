require 'rails_helper'

describe Card do

  before { @card = Card.new(original_text: "text", translated_text: "текст", review_date: Time.parse("25-07-2014")) }

  describe "check translation" do
    before(:each) do
      @typo_count = rand(0..3)
      @time_factor = rand(0...2.0) 
    end

    it "should check wrong translation" do
      expect(@card.check("что-то", @typo_count, @time_factor)).to eq :error
    end

    it "should check right translation" do
      expect(@card.check("текст", @typo_count, @time_factor)).to eq :success
    end

    it "should check translation with typo" do
      expect(@card.check("текстт", @typo_count, @time_factor)).to eq :typo
    end
  end

  describe "update card attributes" do
    
    before(:each) do 
      t = Time.parse("21-07-2014")
      allow(Time).to receive(:now) { t }

      @numb_correct_answers = 5
      @numb_incorrect_answers = 2
      @time_factor = 0.6 
      @ef = 2.5
      @interval = 12
    end

    describe "when user answers correctly" do
      describe "and number correct answers eq 0" do
        let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: 0, 
                                               numb_incorrect_answers: 2, ef: @ef, interval: @interval) }

        before(:each) { card.process_correct_answer(0, @time_factor) }

        it { expect(card.interval).to eq 1}
        it { expect(card.review_date).to eq (Time.now + 1.day) }
        it { expect(card.numb_correct_answers).to eq 1 }
        it { expect(card.numb_incorrect_answers).to eq 0 }
      end

      describe "and number correct answers eq 1" do
        let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: 1, 
                                               numb_incorrect_answers: 2, ef: @ef, interval: @interval) }

        before(:each) { card.process_correct_answer(0, @time_factor) }

        it { expect(card.interval).to eq 6}
        it { expect(card.review_date).to eq (Time.now + 6.day) }
        it { expect(card.numb_correct_answers).to eq 2 }
        it { expect(card.numb_incorrect_answers).to eq 0 }
      end

      describe "and number correct answers larger 2" do
        let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: @numb_correct_answers, 
                                               numb_incorrect_answers: 2, ef: @ef, interval: @interval) }

        before(:each) { card.process_correct_answer(0, @time_factor) }
          
        it { expect(card.review_date).to eq (Time.now + card.interval.day) }
        it { expect(card.numb_correct_answers).to eq (@numb_correct_answers + 1) }
        it { expect(card.numb_incorrect_answers).to eq 0 }
      end
    end

    describe "when user answers incorrectly" do
      describe "when number incorrect answer less 3" do 
        let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: @numb_correct_answers, 
                                               numb_incorrect_answers: @numb_incorrect_answers, ef: @ef, interval: @interval) }
        before(:each) { card.process_incorrect_answer }

        it { expect(card.review_date).to eq Time.now }
        it { expect(card.numb_correct_answers).to eq (@numb_correct_answers) }
        it { expect(card.numb_incorrect_answers).to eq (@numb_incorrect_answers + 1) }
      end

      describe "when number incorrect answer eq 3" do 
        let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: @numb_correct_answers, 
                                               numb_incorrect_answers: 3, ef: @ef, interval: @interval) }
        before(:each) { card.process_incorrect_answer }

        it { expect(card.review_date).to eq Time.now }
        it { expect(card.ef).to eq 1.3 }
        it { expect(card.interval).to eq 1 }
        it { expect(card.numb_correct_answers).to eq 0 }
        it { expect(card.numb_incorrect_answers).to eq 0 }
      end
    end
  end
end

