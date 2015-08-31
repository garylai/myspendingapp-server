require 'UUIDHelper'

class User < ActiveRecord::Base
  include UUIDHelper
end
