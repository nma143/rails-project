class BooksController < ApplicationController
before_action :require_logged_in

  def index
    @books = Book.all
  end

  def show

  end




end
