require 'password_helper'
require 'uuid_helper'

class User < ActiveRecord::Base
  include UUIDHelper

  acts_as_paranoid

  attr_accessor :password

  validates :password, presence: true, if: :validate_password?
  validates :first_name, :last_name, :hashed_password, :salt, presence: true
  validates :email, email: true, uniqueness: true

  attr_readonly :hashed_password, :salt

  self.primary_key = :id
  has_many :spendings, :dependent => :destroy

  private_error_attributes :hashed_password, :salt

  def as_json(options={})
     options[:except] ||= [:hashed_password, :salt]
     super(options)
  end

  def is_password_correct?(pw)
    return false if self[:hashed_password].blank? || self[:salt].blank?
    PasswordHelper.validate_password pw, self[:hashed_password], self[:salt]
  end

  def password=(pw)
    @password_changed = true

    return if !pw.is_a?(String) || pw.empty?
    ret = PasswordHelper.create_hash(pw)
    self[:hashed_password] = ret[:hashed_password]
    self[:salt] = ret[:salt]

    @password = pw
  end

  def validate_password?
    self.new_record? || @password_changed
  end
end
