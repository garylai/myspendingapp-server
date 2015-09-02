class AddPassowrdColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :password, :string, :null => false
    add_column :users, :salt, :string, :null => false
  end
end
