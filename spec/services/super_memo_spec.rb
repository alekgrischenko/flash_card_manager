require 'rails_helper'

describe SuperMemo do
  
  before(:each) do
    @interval = 10
    @e_factor = 2.5
    @numb_correct_answers = 1
    @typo_count = 0
    @time = 20000
    @translated_text_length = 10
  end

  describe "calculate e-factor" do 

    it "when time factor larger 0.5" do
      time = 15000
      supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, time, @translated_text_length, @numb_correct_answers)
      expect(supermemo.e_factor).to eq (@e_factor + 0.1 * @translated_text_length * 1000 / time)
    end

    it "when time factor less 0.5" do
      time = 30000
      supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, time, @translated_text_length, @numb_correct_answers)
      expect(supermemo.e_factor).to eq @e_factor
    end

    it "when typo count eq 1" do
      typo_count = 1
      supermemo = SuperMemo.new(@interval, @e_factor, typo_count, @time, @translated_text_length, @numb_correct_answers)
      expect(supermemo.e_factor).to eq (@e_factor - 0.14 * @translated_text_length * 1000 / @time)
    end
  end

  describe "calculate interval" do
    describe "when typo count less or equal than 1" do
      it "and number correct answers eq 1" do
        numb_correct_answers = 1
        supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, @time, @translated_text_length, numb_correct_answers)
        expect(supermemo.interval).to eq 1
      end

      it "and number correct answers eq 2" do
        numb_correct_answers = 2
        supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, @time, @translated_text_length, numb_correct_answers)
        expect(supermemo.interval).to eq 6
      end

      describe "and number correct answers larger 2" do
        it "and interval * e_factor < 365" do
          numb_correct_answers = 3
           supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, @time, @translated_text_length, numb_correct_answers)
          expect(supermemo.interval).to eq @interval * @e_factor
        end

        it "and interval * e_factor larger or equal than 365" do
          numb_correct_answers = 3
          interval = 150
          supermemo = SuperMemo.new(interval, @e_factor, @typo_count, @time, @translated_text_length, numb_correct_answers)
          expect(supermemo.interval).to eq 365
        end
      end
    end

    describe "when typo count larger 1" do

      before(:each) { @typo_count = 2 }

      it "and interval larger e-factor" do
        supermemo = SuperMemo.new(@interval, @e_factor, @typo_count, @time, @translated_text_length, @numb_correct_answers)
        expect(supermemo.interval).to eq @interval / @e_factor
      end

      it "and interval less or equal than e-factor " do
        interval = 2
        supermemo = SuperMemo.new(interval, @e_factor, @typo_count, @time, @translated_text_length, @numb_correct_answers)
        expect(supermemo.interval).to eq 1
      end
    end
  end
end
