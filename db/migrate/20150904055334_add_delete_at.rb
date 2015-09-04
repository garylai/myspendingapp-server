class AddDeleteAt < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
    add_column :spendings, :deleted_at, :datetime
    add_index :spendings, :deleted_at
  end
end
