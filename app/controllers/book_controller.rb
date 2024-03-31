class BookController < ApplicationController
  def index
    @books = policy_scope(Book)
  end

  def create
    @book = Book.new(published_at:Time.now, author: Author.first)

    if @book.save
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end
end
