require 'UUIDHelper'
require 'PasswordHelper'

class User < ActiveRecord::Base
  include UUIDHelper
end
