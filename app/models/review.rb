class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :stars, presence: true
  validates :content, presence: true
  validates :stars, inclusion: { in: [0, 1, 2, 3]}

  validate  :user_has_not_reviewed_book_already

  def user_has_not_reviewed_book_already
    # If the review already has an id, then we are doing an update
    # This validation should not stop an update.
    # If the review has no id, it's a new review, so check to see if the
    # user has already reviewed the book
    if !id && Review.find_by(user_id: user_id, book_id: book_id)
      errors.add(:user_id, "already reviewed this book")
    end
  end

end
