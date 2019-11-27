class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

	def new
		@book_new = Book.new
  end

  def create
  	@book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
	  if @book_new.save
    	flash[:notice] = "Book was successfully created."
    	redirect_to book_path(@book_new.id)
    else
    	@books = Book.all
    	render :index
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new
  end

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @book_commentnew = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
    if @book.update(book_params)
    	flash[:notice] = "Book was successfully update."
    	redirect_to book_path(@book.id)
    else
    	render :edit
  	end
  end

	def destroy
  	@book = Book.find(params[:id])
    if @book.destroy
    	flash[:notice] = "Book was successfully destroyed."
    	redirect_to '/books'
    end
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
