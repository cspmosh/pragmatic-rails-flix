Rails.application.routes.draw do
  
  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users
  
  get "signin" => "sessions#new"
  get "signup" => "users#new"
end
