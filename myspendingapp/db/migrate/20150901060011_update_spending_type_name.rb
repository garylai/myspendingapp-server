class UpdateSpendingTypeName < ActiveRecord::Migration
  def change
    rename_column :spendings ,:type, :spending_type
  end
end
