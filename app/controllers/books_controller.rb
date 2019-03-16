class BooksController < ApplicationController
before_action :require_logged_in

  def index
    @books = Book.order_by_title
  end

  def most_reviewed

    @books = Book.order_by_most_reviewed
    render :index

  end

  def highest_average
    @books = Book.order_by_avg_stars
    render :index
  end

  def author_order
    @books = Book.order_by_author
    render :index
  end


end
