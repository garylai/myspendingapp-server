class DeleteNameFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :name
  end
  def down
    add_column :users, :name, :string, :null => false
    User.all.each do |u|
      u.name = "#{u.first_name} #{u.last_name}"
      u.save
    end
  end
end
