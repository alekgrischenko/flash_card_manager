class AddEfAndIntervalToCards < ActiveRecord::Migration
  def change
    add_column :cards, :ef, :float, default: 2.5
    add_column :cards, :interval, :float, default: 1.0
  end
end
