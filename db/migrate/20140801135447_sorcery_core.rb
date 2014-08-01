class SorceryCore < ActiveRecord::Migration
  def change
    add_column :users, :crypted_password, :string, null: false
    add_column :users, :salt, :string, null: false
    remove_column :users, :password
  end
end
