class User < ApplicationRecord
  has_many  :reviews
  has_many :books, through: :reviews

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  #username can only be lowercase letters and numbers
  validates_format_of :username, :with => /\A[a-z0-9]+\z/

  #email format - simplest successful format is a@b.c
  validates_format_of :email, :with => /\A[a-z0-9\._]+@[a-z\d\-]+(\.[a-z\d\-]+)\z/

  validates :username, uniqueness:  true
  validates :email, uniqueness:  true

  def self.find_or_create_by_omniauth(auth_hash)

    auth_email = auth_hash[:extra][:raw_info][:email]

    if user = self.find_by(:email => auth_email)
      # User already in db, then can just be logged in
      return user
    else
      # This is the first time this email has been used
      # Create a user with the auth_email, make a username for them, and give fake password
      auto_username = self.create_username_from_email(auth_email)
      fake_password = SecureRandom.hex
      user = self.create(username: auto_username, email: auth_email, password: fake_password)
    end

  end

  def self.create_username_from_email(email)
    # get a starting point for the username from the email
    # if can't get something from the email, just use anonymous
    email_root = email.split("@")[0]
    username_root = /[a-z0-9]+/.match(email_root)[0] if /[a-z0-9]+/.match(email_root)
    username_root ||= "anonymous"

    # By now username_root won't be blank, and won't contain invalid characters
    # Will need to check it is unique
    # If not, add a suffix that results in unquie username
    suffix = 0
    username = username_root
    while self.find_by(username: username) do
      suffix = suffix + 1
      username = username_root + suffix.to_s
    end
    username
  end
end
