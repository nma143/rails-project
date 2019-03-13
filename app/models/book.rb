class Book < ApplicationRecord
  has_many  :reviews
  has_many :users, through: :reviews


  def average_star_rating

    if self.reviews.size >=1
      star_ratings = self.reviews.collect {|review| review.stars}
      avg_star_rating = (star_ratings.sum/star_ratings.size.to_f).round(1)
    end
  end

end
