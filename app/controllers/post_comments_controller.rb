class PostCommentsController < ApplicationController

# コメント作成
  def create
  @book = Book.find(params[:book_id])
  comment = PostComment.new(post_comment_params)
  comment.user_id = current_user.id
  comment.book_id = @book.id
  comment.save
  @post_comment = PostComment.new

  # redirect_to book_path(book)→非同期
  end

# コメント削除
  def destroy
  # PostComment.find(params[:id]).destroy
  # redirect_to book_path(params[:book_id])→非同期
  @book=Book.find(params[:book_id])
  @post_comment=PostComment.find_by(id: params[:id], book_id: params[:book_id])
  @post_comment.destroy
  @post_comment = PostComment.new
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end