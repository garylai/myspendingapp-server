class AddIndexToSpendingTable < ActiveRecord::Migration
  def change
    add_index :spendings, [:year_of_spending, :month_of_spending, :day_of_spending], :name => "spendings_on_year_month_day"
  end
end
