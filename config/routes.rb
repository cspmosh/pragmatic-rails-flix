Rails.application.routes.draw do
  
  resources :favorites
  root "movies#index"
  resources :movies do
    resources :reviews
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users
  get "signin" => "sessions#new"
  get "signup" => "users#new"
end
