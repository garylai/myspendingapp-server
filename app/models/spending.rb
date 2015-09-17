require 'uuid_helper'

class Spending < ActiveRecord::Base
  acts_as_paranoid

  include UUIDHelper

  attr_readonly :year_of_spending, :month_of_spending, :day_of_spending

  self.primary_key = :id
  belongs_to :user
  belongs_to :spending_type
  validates :value, :presence => true, :numericality => true
  validates :year_of_spending, :month_of_spending, :day_of_spending, :presence => true, :numericality => { only_integer: true }

  validates_presence_of :date_of_spending, :user, :spending_type
  validate :validate_date_of_spending

  private_error_attibutes :year_of_spending, :month_of_spending, :day_of_spending

  def validate_date_of_spending
    errors.add(:date_of_spending, "incorrect format") unless date_of_spending.is_a? Date
  end

  def date_of_spending=(newDate)
    return unless newDate.is_a? Date
    self[:year_of_spending] = newDate ? newDate.year : nil
    self[:month_of_spending] = newDate ? newDate.month : nil
    self[:day_of_spending] = newDate ? newDate.day : nil
    self[:date_of_spending] = newDate
  end

  def self.sum_over_years
    select('sum(value) as total, year_of_spending').
      group(:year_of_spending).
      order(year_of_spending: :desc)
  end

  def self.sum_over_months(year)
    select('sum(value) as total, month_of_spending').
      where({:year_of_spending => year}).
      group(:month_of_spending).
      order(month_of_spending: :desc)
  end

  def self.sum_over_days(year, month)
    select('sum(value) as total, day_of_spending').
      where({:year_of_spending => year, :month_of_spending => month}).
      group(:day_of_spending).
      order(day_of_spending: :desc)
  end
  def self.in_day(date_of_spending)
    joins(:spending_type).
      select('spendings.id, spendings.value, spending_types.name as spending_type_name').
      where({:date_of_spending => date_of_spending}).
      order(created_at: :desc)
  end
end
