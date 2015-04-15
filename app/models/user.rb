class User < ActiveRecord::Base

  # Save all the emails as downcase since we are going with non-case-sensitive
  before_save { self.email = email.downcase }

  # Name field of user object is required in creating, with maximum length of 50 charaters
  validates :name, presence: true, length: { maximum: 50 }
  # Check email format with given regex(validity check)
  # Also always has to be present, with maximum length of 255 characters
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # Check if password is secure to use 
  has_secure_password
  # Once pass the has_secure_password test, check the length to be minimum 6 characters
  validates :password, length: { minimum: 6 }
end