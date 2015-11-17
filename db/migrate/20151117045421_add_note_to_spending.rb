class AddNoteToSpending < ActiveRecord::Migration
  def change
    add_column :spendings, :note, :string, :limit => 100, :null => true
  end
end
