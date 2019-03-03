class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @books_to_review = Book.all - current_user.books
  end

  def create
    @review = Review.new(:content => params[:content], :stars => params[:stars], :user_id => session[:user_id], :book_id => params[:book_id])

    if @review.save
      redirect_to user_path(current_user)
    else
      render :new
    end

  end


end
