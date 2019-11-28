Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'home/about' => 'homes#about'

  post 'books/:id' => 'book_comment#create'
  get 'books/:id/book_comments' => 'books#show'

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
  	resources :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy, :edit, :update]
  end

  resources :users, only: [:show, :index, :edit, :update]

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

end
