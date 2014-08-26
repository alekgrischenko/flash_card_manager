require 'rails_helper'

describe Card do

  before { @card = Card.new(original_text: "text", translated_text: "текст", review_date: Time.parse("25-07-2014")) }

  describe "check translation" do
    it "should check wrong translation" do
      expect(@card.check("что-то")).to be false
    end

    it "should check right translation" do
      expect(@card.check("текст")).to be true
    end
  end

  describe "update review_date" do
    
    before(:each) do 
      t = Time.parse("21-07-2014")
      allow(Time).to receive(:now) { t }
    end

    describe "when number correct answer eq 0" do
      let(:card) { FactoryGirl.create(:card, original_text: "text", translated_text: "текст", numb_correct_answers: 0, numb_incorrect_answers: 3) }

      describe "and correct answer" do
        before(:each) { card.process_correct_answer }
        
        it { expect(card.review_date).to eq (Time.now + 12.hour) }
        it { expect(card.numb_correct_answers).to eq 1 }
        it { expect(card.numb_incorrect_answers).to eq 0 }
      end

      describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 0, numb_incorrect_answers: 0) }
          
          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 0 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 0, numb_incorrect_answers: 1) }
                 
          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 0 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 0, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 0 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 0, numb_incorrect_answers: 3) }
          
          it { expect(card.review_date).to eq Time.now }
          it { expect(card.numb_correct_answers).to eq 0 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end

    describe "when number correct answer eq 1" do
      before(:each) do 
        @card = Card.create(original_text: "text", translated_text: "текст", numb_correct_answers: 1, numb_incorrect_answers: 3) 
      end

      describe "and correct answer" do
        before(:each) { @card.process_correct_answer }
        
        it { expect(@card.review_date).to eq (Time.now + 3.day) }
        it { expect(@card.numb_correct_answers).to eq 2 }
        it { expect(@card.numb_incorrect_answers).to eq 0 }
      end

      describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 1, numb_incorrect_answers: 0) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 1 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 1, numb_incorrect_answers: 1) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 1 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 1, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 1 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 1, numb_incorrect_answers: 3) }

          it { expect(card.review_date).to eq Time.now }
          it { expect(card.numb_correct_answers).to eq 0 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end

    describe "when number correct answer eq 2" do
      before(:each) do 
        @card = Card.create(original_text: "text", translated_text: "текст", numb_correct_answers: 2, numb_incorrect_answers: 3) 
      end

      describe "and correct answer" do 
        before(:each) { @card.process_correct_answer }
        
        it { expect(@card.review_date).to eq (Time.now + 1.week) }
        it { expect(@card.numb_correct_answers).to eq 3 }
        it { expect(@card.numb_incorrect_answers).to eq 0 }
      end

      describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 2, numb_incorrect_answers: 0) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 2 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 2, numb_incorrect_answers: 1) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 2 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 2, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 2 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 2, numb_incorrect_answers: 3) }

          it { expect(card.review_date).to eq (Time.now + 12.hour) }
          it { expect(card.numb_correct_answers).to eq 1 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end

    describe "when number correct answer eq 3" do
      before(:each) do 
        @card = Card.create(original_text: "text", translated_text: "текст", numb_correct_answers: 3, numb_incorrect_answers: 3) 
      end

      describe "and correct answer" do
        before(:each) { @card.process_correct_answer }
        
        it { expect(@card.review_date).to eq (Time.now + 2.week) }
        it { expect(@card.numb_correct_answers).to eq 4 }
        it { expect(@card.numb_incorrect_answers).to eq 0 }
      end

      describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 3, numb_incorrect_answers: 0) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 3 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 3, numb_incorrect_answers: 1) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 3 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 3, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 3 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 3, numb_incorrect_answers: 3) }

          it { expect(card.review_date).to eq (Time.now + 3.day) }
          it { expect(card.numb_correct_answers).to eq 2 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end

    describe "when number correct answer eq 4" do
      before(:each) do 
        @card = Card.create(original_text: "text", translated_text: "текст", numb_correct_answers: 4, numb_incorrect_answers: 3) 
      end

      describe "and correct answer" do
        before(:each) { @card.process_correct_answer }
        
        it { expect(@card.review_date).to eq (Time.now + 1.month) }
        it { expect(@card.numb_correct_answers).to eq 5 }
        it { expect(@card.numb_incorrect_answers).to eq 0 }
      end

      describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 4, numb_incorrect_answers: 0) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 4 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 4, numb_incorrect_answers: 1) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 4 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 4, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 4 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 4, numb_incorrect_answers: 3) }

          it { expect(card.review_date).to eq (Time.now + 1.week) }
          it { expect(card.numb_correct_answers).to eq 3 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end

    describe "when number correct answer eq 5" do
      before(:each) do 
        @card = Card.create(original_text: "text", translated_text: "текст", numb_correct_answers: 5, numb_incorrect_answers: 3) 
      end

      describe "and correct answer" do
        before(:each) { @card.process_correct_answer }
        
        it { expect(@card.review_date).to eq (Time.now + 1.month) }
        it { expect(@card.numb_correct_answers).to eq 5 }
        it { expect(@card.numb_incorrect_answers).to eq 0 }
      end

        describe "and incorrect answer" do
        before(:each) { card.process_incorrect_answer }

        describe "number incorrect answer eq 0" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 5, numb_incorrect_answers: 0) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 5 }
          it { expect(card.numb_incorrect_answers).to eq 1 }
        end

        describe "number incorrect answer eq 1" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 5, numb_incorrect_answers: 1) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 5 }
          it { expect(card.numb_incorrect_answers).to eq 2 }
        end

        describe "number incorrect answer eq 2" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 5, numb_incorrect_answers: 2) }

          it { expect(card.review_date).to eq Time.parse("21-07-2014") }
          it { expect(card.numb_correct_answers).to eq 5 }
          it { expect(card.numb_incorrect_answers).to eq 3 }
        end

        describe "number incorrect answer eq 3" do
          let(:card) { FactoryGirl.create(:card, numb_correct_answers: 5, numb_incorrect_answers: 3) }

          it { expect(card.review_date).to eq (Time.now + 2.week) }
          it { expect(card.numb_correct_answers).to eq 4 }
          it { expect(card.numb_incorrect_answers).to eq 0 }
        end
      end
    end
  end
end

