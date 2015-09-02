require 'securerandom'
require 'openssl'
require 'base64'

module PasswordHelper

  ITERATIONS = 1000
  SALT_SIZE = 24 # in byte
  HASH_SIZE = 64 # in byte

  def self.create_hash(password)
    salt = SecureRandom.base64(SALT_SIZE)
    pbkdf2 = OpenSSL::PKCS5::pbkdf2_hmac_sha1(
      password,
      salt,
      ITERATIONS,
      HASH_SIZE
    )
    return {:salt => salt, :hashed_password => Base64.encode64(pbkdf2)}
  end

  def self.validate_password(password, hashed_password, salt)
    pbkdf2 = Base64.decode64(hashed_password)
    testHash = OpenSSL::PKCS5::pbkdf2_hmac_sha1(
      password,
      salt,
      ITERATIONS,
      HASH_SIZE
    )
    return pbkdf2 == testHash
  end

end
