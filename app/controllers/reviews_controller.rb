class ReviewsController < ApplicationController
before_action :require_logged_in
before_action :set_review, only: [:edit, :update, :destroy]
before_action :set_book, only: [:index, :new, :edit]

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
      redirect_to user_path(current_user)
    else
      redirect_to new_review_path
    end

  end

  def destroy
    if @review && @review.user == current_user
      @review.delete
      redirect_to user_path(current_user)
    else
      # put some error handling here
    end

  end


  def edit

  end

  def update
    if @review.update(review_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_book
    @book = Book.find_by_id(params[:book_id])
  end

  def review_params
    params.require(:review).permit(
      :content,
      :stars,
    )
  end
end
