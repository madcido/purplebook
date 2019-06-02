Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :update]
  resources :posts, except: [:new]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friendships, only: [:create, :update, :destroy]

  root to: "posts#index"
end
