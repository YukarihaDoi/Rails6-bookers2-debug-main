class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @nbook = Book.new
  end

  def index
    @users = User.all
    @nbook = Book.new

   def edit
    @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
   end

private

   def user_param
    params.require(:user).permit(:name, :introduction, :profile_image)
   end

    def ensure_correct_user
     @user = User.find(params[:id])

      if @user != current_user
       redirect_to user_path(current_user)
      end
    end
  end
end