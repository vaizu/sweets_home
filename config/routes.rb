Rails.application.routes.draw do
  devise_for :users
  root :to =>"homes#top"
  resources :users, only: [:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :notifications, only: :index do
      collection do
        delete :destroy_all
      end
    end

  end

  resources :posts, only: [:new,:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :recipes, only: [:new,:show,:edit,:update,:create,:destroy]
  end

  get 'search' => 'posts#search'


  resources :genres, only: [:show]




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
