class FavoritesController < ApplicationController

  before_action :require_signin

  def create 
    @movie = Movie.find(params[:movie_id])
    @movie.favorites.new(user: current_user)
    if @movie.save
      redirect_to @movie
    end
  end
end
