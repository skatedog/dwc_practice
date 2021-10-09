module ApplicationHelper
  def create_favorite_book_ids
    @favorite_book_ids = current_user.favorites.pluck(:book_id)
  end

  def create_following_ids
    @following_ids = current_user.following.pluck(:id)
  end
end
