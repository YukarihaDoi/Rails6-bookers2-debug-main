class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save

    path = Rails.application.routes.recognize_path(request.referer)
    if path[:action] == "books#index"

    redirect_to book_path(book)
    else
    redirect_to book_path(book)
    end

  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy

    if current_page?(books_path)

    redirect_to book_path(book)
    else
    redirect_to book_path(book)
    end

  end
end
