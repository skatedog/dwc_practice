class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :make_favorite_book_ids, only: [:index, :show, :create]

  def index
    @books = Book.all
  end

  def show
    @book = Book.includes(book_comments: :user).find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def create
    @new_book = current_user.books.new(book_params)
    if @new_book.save
      redirect_to book_path(@new_book)
      flash[:notice] = 'You have created book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :body)
    end

    def ensure_correct_user
      book = Book.find(params[:id])
      unless book.user == current_user
        redirect_to books_path
      end
    end
end
