class ReviewsController < ApplicationController
before_action :require_logged_in
before_action :set_book, only: [:index, :new, :edit, :update]
before_action :set_review, only: [:edit, :update]
before_action :check_user_is_reviewer, only: [:edit, :update]



  def index
    @reviews = @book.reviews
  end


  def new
    @review = Review.new
  end

  def create

    @review = Review.new(:content => params[:review][:content],
                          :stars => params[:review][:stars],
                          :user_id => session[:user_id],
                          :book_id => params[:book_id])

    if @review.save
      redirect_to user_path(current_user), notice: "Review successfully saved"
    else
      set_book
      render :new
    end

  end

  def destroy
    @review = Review.find_by_id(params[:id])
    if @review && @review.user == current_user
      @review.delete
      redirect_to user_path(current_user), notice: "Review successfully deleted"
    else
      redirect_to user_path(current_user), alert: "Review not deleted"
    end

  end


  def edit

  end

  def update
    if @review.update(review_params)
      redirect_to user_path(current_user), notice: "Review successfully updated"
    else
      render :edit
    end
  end

  private

  def set_review
    # for nested routes, make sure the review belongs to the book
    # example: books/1/reviews/39/edit vs books/3/reviews/39/edit
    @review = @book.reviews.find_by_id(params[:id])
    redirect_to books_path, alert: "Review not found" unless @review
  end

  def set_book
    @book = Book.find_by_id(params[:book_id])
    redirect_to books_path, alert: "Book not found" unless @book
  end

  def check_user_is_reviewer
    redirect_to user_path(current_user), alert: "You didn't write that review" unless @review.user == current_user
  end


  def review_params
    params.require(:review).permit(
      :content,
      :stars,
    )
  end
end
