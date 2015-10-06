class CreateDummyData < ActiveRecord::Migration
  def up
    SpendingType.create({:name => "food", :id => 1})
    SpendingType.create({:name => "entertainment", :id => 2})
    SpendingType.create({:name => "transportation", :id => 3})
    SpendingType.create({:name => "clothing", :id => 4})
    SpendingType.create({:name => "recurring expenditure", :id => 5})
    SpendingType.create({:name => "others", :id => 6})
    
    unless Rails.env.production?
      u = User.new
      u.name = "Gary Lai"
      u.email = "garylaiph@gmail.com"
      u.password = "abcd!234"
      u.save

      u.reload

      spendingTypes = SpendingType.all
      startingDate = Date.new(2014, 10, 20)
      500.times do |i|
      date = startingDate + i.day
        rand(5).times do
          s = u.spendings.build
          s.value = (rand(1000) + 100) / 10.0
          s.spending_type = spendingTypes[rand(spendingTypes.count)]
          s.date_of_spending = date

          s.save
        end
      end
    end
  end
  def down
    unless Rails.env.production?
      Spending.delete_all
      User.delete_all
      SpendingType.delete_all
    end
  end
end
