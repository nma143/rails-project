class ReviewsController < ApplicationController

  def new
    
    @books_to_review = Book.all - current_user.books
  end


end
