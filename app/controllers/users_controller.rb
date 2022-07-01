class UsersController < ApplicationController
before_action :ensure_currect_user, only: [:edit,:update]

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @nbook = Book.new
  end
  # ユーザー一覧画面
  def index
    @users = User.all
    @nbook = Book.new
  end
  # ユーザー編集画面（自分のみ）
  def edit
   @user = User.find(params[:id])
  end
  # 編集更新(自分のみ)
  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  # フォロワー 一覧画面
  def follower
   @user = User.find(params[:id])

  end
  # フォロー 一覧画面
  def following
   @user = User.find(params[:id])

  end

private
   def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
   end

    def ensure_currect_user
     @user = User.find(params[:id])
      unless @user == current_user
       redirect_to user_path(current_user.id)
      end
    end
end
