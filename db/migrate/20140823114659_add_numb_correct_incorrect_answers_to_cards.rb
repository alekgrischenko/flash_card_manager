class AddNumbCorrectIncorrectAnswersToCards < ActiveRecord::Migration
  def change
    add_column :cards, :numb_correct_answers, :integer
    add_column :cards, :numb_incorrect_answers, :integer
  end
end
