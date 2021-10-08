class FavoritesController < ApplicationController
  def create
    current_user.favorites.create(book_id: params[:book_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.favorites.find_by(book_id: params[:book_id]).destroy
    redirect_back(fallback_location: root_path)
  end
end
