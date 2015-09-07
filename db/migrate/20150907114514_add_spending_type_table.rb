class AddSpendingTypeTable < ActiveRecord::Migration
  def change
    create_table :spending_types do |t|
      t.string :name, :null => false
      t.datetime :deleted_at, :index => true

      t.timestamps null: false
    end
    add_index :spending_types, :name, :unique => true
    remove_column :spendings, :spending_type, :string
    add_reference :spendings, :spending_type, :null => false, :foreign_key => true, :index => true
  end
end
