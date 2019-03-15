Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#home"
  get "/login", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:show, :create]

  resources :books, only: [:index] do
    resources :reviews, only: [:index]
  end
  resources :reviews, only: [:new, :create, :show, :edit, :destroy, :update]

  get "books/most_reviewed", to: "books#most_reviewed"
  get "books/highest_average", to: "books#highest_average"
  get "books/author_order", to: "books#author_order"

end
