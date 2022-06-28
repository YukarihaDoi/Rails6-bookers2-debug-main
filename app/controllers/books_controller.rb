class BooksController < ApplicationController

  def show
   @nbook = Book.new
   @book = Book.find(params[:id])
   @user = @book.user
   @post_comment = PostComment.new
  end

  def index
    @nbook = Book.new
    @books = Book.all
    @post_comment = PostComment.new
  end

  def create
    @nbook = Book.new(book_params)
    @nbook.user_id = current_user.id

    if @nbook.save
      redirect_to book_path(@nbook), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
     @book = Book.find(params[:id])
     if @book.user == current_user
     render :edit
     else
     redirect_to books_path
     end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

end