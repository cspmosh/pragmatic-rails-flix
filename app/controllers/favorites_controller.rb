class FavoritesController < ApplicationController

  before_action :require_signin

  def create 
    @movie = Movie.find(params[:movie_id])
    @movie.favorites.new(user: current_user)
    if @movie.save
      redirect_to @movie
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy
    
    redirect_to Movie.find(params[:movie_id])
  end
end
