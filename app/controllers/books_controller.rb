class BooksController < ApplicationController
before_action :require_logged_in

  def index
    @books = Book.order_by_title
  end

  def show

  end

  def most_reviewed

    @books = Book.order_by_most_reviewed
    render :index
    #Good! I want to show the number of reviews now
    #Also, I think I could probably use a partial here to make this view
    # a little different than the index view

  end

  def highest_average
    @books = Book.order_by_avg_stars
    render :index
  end


end
