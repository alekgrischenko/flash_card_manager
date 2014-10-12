require 'rails_helper'

describe "SuperMemo" do
  
  before(:each) do
    @interval = 10
    @e_factor = 2.5
    @numb_correct_answers = 1
    @typo_count = 0
    @time_factor = 0.5
  end

  describe "calculate e-factor" do 
    
    it "time factor larger 0.5" do
      time_factor = 0.7
      expect(SuperMemo.new(@interval, @e_factor, @numb_correct_answers).calculate_e_factor(@typo_count, time_factor).round(2)).to eq (@e_factor + 0.1 * time_factor)
    end

    it "time factor less 0.5" do
      time_factor = 0.4
      expect(SuperMemo.new(@interval, @e_factor, @numb_correct_answers).calculate_e_factor(@typo_count, time_factor).round(2)).to eq @e_factor
    end

    it "typo count eq 1" do
      typo_count = 1
      expect(SuperMemo.new(@interval, @e_factor, @numb_correct_answers).calculate_e_factor(typo_count, @time_factor).round(2)).to eq (@e_factor - 0.14 * @time_factor)
    end
  end

  describe "calculate interval" do
    describe "typo count <= 1" do
      it "number correct answers eq 1" do
        numb_correct_answers = 1
        expect(SuperMemo.new(@interval, @e_factor, numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq 1
      end

      it "number correct answers eq 2" do
        numb_correct_answers = 2
        expect(SuperMemo.new(@interval, @e_factor, numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq 6
      end

      describe "number correct answers larger 2" do
        it "and interval * e_factor < 365" do
          numb_correct_answers = 3
          expect(SuperMemo.new(@interval, @e_factor, numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq @interval * @e_factor
        end

        it "and interval * e_factor >= 365" do
          numb_correct_answers = 3
          interval = 150
          expect(SuperMemo.new(interval, @e_factor, numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq 365
        end
      end
    end

    describe "typo_count > 1" do

      before(:each) { @typo_count = 2 }

      it "and interval larger e-factor" do
        expect(SuperMemo.new(@interval, @e_factor, @numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq @interval / @e_factor
      end

      it "and interval <= e-factor " do
        interval = 2
        expect(SuperMemo.new(interval, @e_factor, @numb_correct_answers).calculate_new_interval(@typo_count, @time_factor)).to eq 1
      end
    end
  end
end
