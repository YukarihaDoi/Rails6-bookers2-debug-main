class PostCommentsController < ApplicationController
  def create
  book = Book.find(params[:book_id])
  comment = current_user.books.new(post_comment_params)
  comment.post_image_id = book.id
  comment.save
  redirect_to book_path(book)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
