class CreateSpendings < ActiveRecord::Migration
  def change
    create_table :spendings, :id => false do |t|
      t.string :id, :limit => 36, :null => false
      t.decimal :value, :null => false, :precision => 20, :scale => 2
      t.string :type, :null => false
      t.date :date_of_spending, :null => false
      t.integer :year_of_spending, :null => false, :limit => 2
      t.integer :month_of_spending, :null => false, :limit => 1
      t.integer :day_of_spending, :null => false, :limit => 1

      t.references :user, :type => :string, :null => false, :foreign_key => true, :index => true

      t.timestamps null: false
    end
    add_index :spendings, :id, :unique => true, :name => 'PRIMARY_KEY'
  end
end
