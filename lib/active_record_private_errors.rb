module ActiveRecordPrivateErrors
  extend ActiveSupport::Concern
  def errors_without_readonly_fields
    err = self.errors.dup
    @@private_error_attibutes.each do |attr|
      err.delete attr
    end
    err
  end

  module ClassMethods
    def private_error_attibutes(*attrs)
      @@private_error_attibutes = attrs
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordPrivateErrors)

# class ActiveRecord::Base
#
#   def self.private_error_attibutes(*attrs)
#     @@private_error_attibutes = attrs
#   end
#
#   def errors_without_readonly_fields
#     err = self.errors.dup
#     @@private_error_attibutes.each do |attr|
#       err.delete attr
#     end
#     err
#   end
#
# end
