require 'UUIDHelper'

class Spending < ActiveRecord::Base
  enum SpendingType: {transportation: 1, food: 2}

  include UUIDHelper

  attr_readonly :year_of_spending, :month_of_spending, :day_of_spending

  self.primary_key = :id
  belongs_to :user
  validates_presence_of :value, :date_of_spending, :year_of_spending, :month_of_spending, :day_of_spending, :user
  validate :validate_spending_type

  def validate_spending_type
    errors.add(:spending_type, "not in " + Spending.SpendingTypes.keys.to_s) unless Spending.SpendingTypes.has_key?(spending_type)
  end

  def date_of_spending=(newDate)
    self[:year_of_spending] = newDate ? newDate.year : nil
    self[:month_of_spending] = newDate ? newDate.month : nil
    self[:day_of_spending] = newDate ? newDate.day : nil
    self[:date_of_spending] = newDate
  end
end
