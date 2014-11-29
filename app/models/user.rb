class User < ActiveRecord::Base
  #  Some database adapters use case-sensitive indices, considering the strings “Foo@ExAMPle.CoM” and “foo@example.com” to be distinct, but our application treats those addresses as the same. To avoid this incompatibility, we’ll standardize on all lower-case addresses, converting “Foo@ExAMPle.CoM” to “foo@example.com” before saving it to the database.

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
