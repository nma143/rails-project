Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#home"
  get "/login", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:show, :create]

  resources :books, only: [:index] do
    resources :reviews, only: [:index, :new, :create, :edit, :update]
  end
  resources :reviews, only: [:destroy]

  get "books/most_reviewed", to: "books#most_reviewed"
  get "books/highest_average", to: "books#highest_average"
  get "books/author_order", to: "books#author_order"


  get '/auth/facebook/callback' => 'sessions#create'
end
