require 'PasswordHelper'
require 'UUIDHelper'

class User < ActiveRecord::Base
  include UUIDHelper

  validates_presence_of :name, :email, :password, :salt
  validates :email, email: true

  self.primary_key = :id
  has_many :spendings, :dependent => :destroy

  def raw_password=(pw)
    ret = PasswordHelper.create_hash(pw)
    self.password = ret[:hashed_password]
    self.salt = ret[:salt]
  end
end
