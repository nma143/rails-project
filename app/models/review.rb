class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :stars, presence: true
  validates :content, presence: true
  validates :stars, inclusion: { in: [0, 1, 2, 3]}

  validate  :user_has_not_reviewed_book_already

  def user_has_not_reviewed_book_already
    if Review.find_by(user_id: user_id, book_id: book_id)
      errors.add(:book_id, "user already reviewed this book")
    end
  end

end
