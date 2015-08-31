class AddUsers < ActiveRecord::Migration
  def change
    create_table :users, :id => false do |t|
      t.string :id, :limit => 36, :null => false
      t.string :name, :null => false
      t.string :email, :null => false, :unique => true

      t.timestamps null: false
    end
    add_index :users, :email, :unique => true
    add_index :users, :id, :unique => true, :name => 'PRIMARY_KEY'
  end
end
