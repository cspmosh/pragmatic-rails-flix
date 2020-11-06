class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    params_allowed = params.require(:movie)
      .permit(:name, :description, :rating, :released_on, :total_gross)
    Movie.update(params_allowed)
    redirect_to @movie
  end
end
