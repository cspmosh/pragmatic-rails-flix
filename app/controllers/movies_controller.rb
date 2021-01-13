class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    case params[:filter]
    when "recent"
      @movies = Movie.recent
    when "upcoming"
      @movies = Movie.upcoming
    else
      @movies = Movie.released
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans
    @genres = @movie.genres
    
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    redirect_to movies_url, danger: "Movie successfully deleted" if @movie.destroy
  end

private

  def movie_params
    params.require(:movie)
      .permit(:name, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
  end
end
