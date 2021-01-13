class GenresController < ApplicationController
  before_action :require_signin, except: [:show]
  before_action :require_admin, except: [:show]
  before_action :find_genre, only: [:show, :edit, :update, :destroy]

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: "Genre successfully added!"
    else
      render :new
    end
  end
  
  def index
    @genres = Genre.all
  end

  def show
    @movies = @genre.movies
  end

  def edit
  end

  def destroy
    redirect_to genres_path, danger: "Genre successfully removed!" if @genre.destroy
  end

  def new
    @genre = Genre.new
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: "Genre successfully updated!"
    else
      render :edit
    end
  end

private

  def genre_params
    params.require(:genre)
      .permit(:name)
  end

  def find_genre
    @genre = Genre.find_by!(slug: params[:id])
  end
end
