Rails.application.routes.draw do
  root "movies#index"
  get "movies" => "movies#index"
  get "movie/:id" => "movies#show", as: "movie"
  get "movie/:id/edit" => "movies#edit", as: "edit_movie"
end
