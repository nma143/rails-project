class ReviewsController < ApplicationController
before_action :set_review, only: [:show, :edit]

  def index
    @book = Book.find_by_id(params[:book_id])
    @reviews = @book.reviews
  end


  def new

    @book = Book.find_by_id(params[:book_id])
    @review = Review.new(:book => @book)
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


  def show

  end

  def destroy
    @review = Review.find_by_id(params[:id])
    if @review && @review.user == current_user
      @review.delete
      redirect_to user_path(current_user)
    else
      render :show
    end

  end


  def edit
    @book = Book.find_by_id(params[:book_id])
    @review = Review.find_by_id(params[:id])

  end

  def update
    @review = Review.find_by_id(params[:id])
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated'
    else
      ender :edit
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(
      :content,
      :stars,
    )
  end
end
