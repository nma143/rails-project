class User < ApplicationRecord
  has_many  :reviews
  has_many :books, through: :reviews

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  validates :username, uniqueness:  true
  validates :email, uniqueness:  true

end
