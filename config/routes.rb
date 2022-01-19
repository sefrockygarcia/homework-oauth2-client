Rails.application.routes.draw do
  devise_for :users
  
  root "users#index"

  resources :users

  get "/auth/homework/callback", to: "homework#callback"
end
