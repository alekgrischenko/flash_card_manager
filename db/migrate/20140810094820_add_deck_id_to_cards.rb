class AddDeckIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :deck_id, :integer
    add_index :cards, :deck_id
  end
end
