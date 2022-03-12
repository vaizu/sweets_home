Rails.application.routes.draw do
  devise_for :users
  root :to =>"homes#top"
  resources :users, only: [:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships/followings', as: 'followings'
    get 'followers' => 'relationships/followers', as: 'followers'
  end

  resources :posts, only: [:new,:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :recipes, only: [:new,:show,:edit,:update,:create]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
