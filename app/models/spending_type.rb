class SpendingType < ActiveRecord::Base
  acts_as_paranoid

  has_many :spendings, :dependent => :restrict_with_exception # because type sholdnt be deleted
  validates :name, :presence => true
end
