class AddNumbCorrectIncorrectAnswersToCards < ActiveRecord::Migration
  def change
    add_column :cards, :numb_correct_answers, :integer, default: 0
    add_column :cards, :numb_incorrect_answers, :integer, default: 0
  end
end
