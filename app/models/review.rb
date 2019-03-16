class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :stars, presence: true
  validates :content, presence: true
  validates :stars, inclusion: { in: [0, 1, 2, 3]}

end
