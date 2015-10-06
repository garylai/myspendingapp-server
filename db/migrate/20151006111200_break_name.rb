class BreakName < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, :null => false
    add_column :users, :last_name, :string, :null => false
    User.all.each do |u|
      names = u.name.split
      u.first_name = names[0]
      u.last_name = names[1] || names[0]
      u.save
    end
  end
  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
