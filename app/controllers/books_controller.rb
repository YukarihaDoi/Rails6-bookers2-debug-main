class BooksController < ApplicationController

# 詳細画面
  def show
   @nbook = Book.new
   @book = Book.find(params[:id])
   @post_comment = PostComment.new
  end
# 投稿一覧
  def index
    @nbook = Book.new
    # @books = Book.all
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> 
    a.favorited_users.size}
    @post_comment = PostComment.new
  end
# 投稿作成
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
# 投稿編集
  def edit
     @book = Book.find(params[:id])
     if @book.user == current_user
     render :edit
     else
     redirect_to books_path
     end
  end
# 編集更新
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
# 投稿削除
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