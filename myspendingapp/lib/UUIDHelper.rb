require 'securerandom'

module UUIDHelper
  def generate_id
    self.id = SecureRandom.uuid.to_s
  end
  def self.included(base)
    base.before_create :generate_id
  end
end
