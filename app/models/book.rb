class Book < ApplicationRecord
  has_many  :reviews
  has_many :users, through: :reviews


  def average_star_rating

    if self.reviews.size >=1
      star_ratings = self.reviews.collect {|review| review.stars}
      avg_star_rating = (star_ratings.sum/star_ratings.size.to_f).round(1)
    end
  end

  def self.order_by_most_reviewed
    # I want to return all the books that have atleast 1 review - ordered by
    # number of reviews (most reviewed at top)

    Book.joins("INNER JOIN reviews ON reviews.book_id = books.id").group("books.id").order("COUNT(books.id) desc")

  end

end
