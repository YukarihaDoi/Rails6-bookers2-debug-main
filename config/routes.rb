Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users
# 上記二つ順番固定

# Aboutページ
  get "home/about"=>"homes#about" ,as:"about"

# フォロー/フォロワーページ
  get 'relationships/followings'
  get 'relationships/followers'

  get "users/:id/following" => "users#following" ,as:"following"
  get "users/:id/follower" => "users#follower" ,as:"follower"

# 本関連ページ
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   resources :post_comments, only: [:create,:destroy]
   resource :favorites, only: [:create, :destroy]
  end

# ユーザー関連ページ
  resources :users, only: [:index,:show,:edit,:update] do
    post 'follow/:id' => 'relationships#create', as: 'follow'
    post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
  end

# 検索結果ページ
  get "/search" => "searches#search", as: 'search'

# DMページ
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end