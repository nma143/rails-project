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
    # I want to return all the books ordered by
    # number of reviews, then number of stars

    Book.joins("LEFT JOIN reviews ON reviews.book_id = books.id").group("books.id").order("count(reviews.book_id) desc, sum(reviews.stars) desc")
  end

  def self.order_by_avg_stars
    Book.all.sort_by{|book| [-book.average_star_rating.to_i, -book.reviews.size]}

  end

end
