class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book.favorites.create(user_id: current_user.id)
    @book.reload
  end

  def destroy
    current_user.favorites.find_by(book_id: params[:book_id]).destroy
    @book = Book.find(params[:book_id])
  end
end
