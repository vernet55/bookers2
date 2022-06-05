Rails.application.routes.draw do

 devise_for :users

  get "home/about" => "homes#about"

  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]


  get 'books/edit'

  root :to =>"homes#top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
