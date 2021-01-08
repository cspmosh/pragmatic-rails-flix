class ReviewsController < ApplicationController
  before_action :require_signin, except: [:index]
  before_action :get_movie
  
  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update
    @review = @movie.reviews.find(params[:id])
    
    if @review.update(review_params)
      redirect_to movie_reviews_url(@movie), notice: "Review updated!"
    else
      render :edit
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    redirect_to movie_reviews_path(params[:movie_id]), danger: "Review successfully deleted" if @review.destroy
  end

  private

  def review_params 
    params.require(:review)
      .permit(:stars, :comment)
  end

  def get_movie
    @movie = Movie.find(params[:movie_id])
  end
end
