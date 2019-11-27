class BookCommentsController < ApplicationController
	before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

	def create
	  @book = Book.find(params[:book_id])
	  @book_commentnew = current_user.book_comments.new(book_comment_params)
	  @book_commentnew.book_id = @book.id
	  if @book_commentnew.save
	    flash[:notice] = "Comment was successfully created."
	    redirect_to book_path(@book)
	  else
	  	@book_new = Book.new
	  	render template: "books/show"
	  end
	end

	def edit
		@book = Book.find(params[:book_id])
		@comment = BookComment.find(params[:id])
	end

	def update
	@book = Book.find(params[:book_id])
	@comment = BookComment.find(params[:id])
  if @comment.update(book_comment_params)
    flash[:notice] = "Comment was successfully update."
    redirect_to book_path(@book.id)
  else
    render :edit
  end
	end

	def destroy
		book = Book.find(params[:book_id])
  	comment = BookComment.find(params[:id])
   	comment.destroy
    flash[:notice] = "Comment was successfully destroyed."
    redirect_to book_path(book)
  end

	private

	def book_comment_params
	  params.require(:book_comment).permit(:comment)
	end

	def correct_user
    comment = BookComment.find(params[:id])
    unless comment.user.id == current_user.id
      redirect_to books_path
    end
  end

end



