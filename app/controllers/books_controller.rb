class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.eager_load(user: :image_attachment)
  end

  def show
    @book = Book.eager_load(:user).preload(book_comments: :user).find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def create
    @new_book = current_user.books.new(book_params)
    if @new_book.save
      redirect_to book_path(@new_book)
      flash[:notice] = 'You have created book successfully.'
    else
      @books = Book.eager_load(user: :image_attachment).preload(:favorites)
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :body)
    end

    def ensure_correct_user
      @book = Book.eager_load(:user).find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
    end
end
