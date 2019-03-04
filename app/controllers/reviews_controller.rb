class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @books_to_review = Book.all - current_user.books
  end

  def create

    @review = Review.new(:content => params[:review][:content],
                          :stars => params[:review][:stars],
                          :user_id => session[:user_id],
                          :book_id => params[:review][:book_id])

    if @review.save
      redirect_to user_path(current_user)
    else
      redirect_to new_review_path
    end

  end


end
