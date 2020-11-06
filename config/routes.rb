Rails.application.routes.draw do
  root "movies#index"
  get "movies" => "movies#index"
  get "movie/:id" => "movies#show", as: "movie"
end
