Rails.application.routes.draw do

  root 'users#new'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :ideas
  resources :likes, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
