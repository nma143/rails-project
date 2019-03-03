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



end
