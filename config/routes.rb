Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#home"
  get "/login", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:show, :create]

  resources :books, only: [:show, :index]
  resources :reviews, only: [:new, :create, :show, :edit, :destroy, :update]
end
