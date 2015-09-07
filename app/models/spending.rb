require 'UUIDHelper'

class Spending < ActiveRecord::Base
  acts_as_paranoid

  enum SpendingType: {transportation: 1, food: 2}

  include UUIDHelper

  attr_readonly :year_of_spending, :month_of_spending, :day_of_spending

  self.primary_key = :id
  belongs_to :user
  validate :value, :presnce => true, :numericality => true
  validate :year_of_spending, :month_of_spending, :day_of_spending, :presence => true, :numericality: { only_integer: true }

  validates_presence_of :date_of_spending, :user
  validate :validate_spending_type
  validate :validate_date_of_spending

  def validate_date_of_spending
    errors.add(:date_of_spending, "incorrect format") unless date_of_spending.is_a? Date
  end
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
