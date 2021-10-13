class BookCommentsController < ApplicationController
  def create
    @book_comment =  current_user.book_comments.create(book_comment_params)
    @book = Book.find(params[:book_id])
  end

  def destroy
    current_user.book_comments.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:body, :book_id)
  end
end
