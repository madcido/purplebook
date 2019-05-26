Rails.application.routes.draw do
  devise_for :users

  resources :posts, except: [:new, :show] do
    resources :comments, except: [:index, :new, :show]
  end

  resources :likes, only: [:create, :destroy]

  resources :friend_requests, only: [:create, :update, :destroy]

  root to: "posts#index"
end
