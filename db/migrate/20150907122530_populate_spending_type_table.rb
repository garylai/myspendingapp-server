class PopulateSpendingTypeTable < ActiveRecord::Migration
  def up
      SpendingType.create(:name => 'food')
      SpendingType.create(:name => 'transportation')
      SpendingType.create(:name => 'entertainment')
  end

  def down
    SpendingType.all.each do |st|
      st.really_destroy!
    end
  end
end
