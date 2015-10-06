class BreakName < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, :null => true
    add_column :users, :last_name, :string, :null => true
    User.all.each do |u|
      names = u.name.split
      u.first_name = names[0]
      u.last_name = names[1] || names[0]
      u.save
    end
    change_column :users, :first_name, :string, :null => false
    change_column :users, :last_name, :string, :null => false
  end
  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
