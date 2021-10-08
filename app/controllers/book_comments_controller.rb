class BookCommentsController < ApplicationController
  def create
    current_user.book_comments.create(book_comment_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.book_comments.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:body, :book_id)
  end
end
