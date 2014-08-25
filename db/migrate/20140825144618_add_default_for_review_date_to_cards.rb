class AddDefaultForReviewDateToCards < ActiveRecord::Migration
  def change
    change_column_default :cards, :review_date, Time.now
  end
end
