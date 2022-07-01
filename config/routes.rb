Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  get 'relationships/followings'
  get 'relationships/followers'

  get "users/:id/following" => "users#following" ,as:"following"
  get "users/:id/follower" => "users#follower" ,as:"follower"

  get "home/about"=>"homes#about" ,as:"about"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   resources :post_comments, only: [:create,:destroy]
   resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    post 'follow/:id' => 'relationships#create', as: 'follow'
    post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
  end

  get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end