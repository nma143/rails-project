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

  def self.create_username_from_email(email)
    # used when user is created via a facebook login

    # get a starting point for the username from the email
    # if can't get something to work with from the email, just use anonymous
    email_root = email.split("@")[0]
    username_root = /[a-z0-9]+/.match(email_root)[0] if /[a-z0-9]+/.match(email_root)
    username_root ||= "anonymous"

    # By now username_root won't be blank, and won't contain invalid characters
    # Will need to check it is unique
    # If not, add a suffix that results in unquie username
    suffix = 0
    username = username_root
    loop do
      user = self.new(username: username)
      user.validate_username
      if user.errors[:username].include?("has already been taken")
        suffix = suffix + 1
        username = username_root + suffix.to_s
      else
        break
      end
    end
    username
  end

    def validate_username
      self.class.validators_on(:username).each do |validator|
        validator.validate_each(self, :username, self.username)
      end
    end

end
