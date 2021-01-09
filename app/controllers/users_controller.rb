class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit;  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to movies_path, alert: "Account successfully deleted!"
  end

private

  def require_admin
    redirect_to movies_path, alert: "Unauthorized access!" unless current_user_admin?
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) || current_user_admin?
  end

  def user_params
    params.require(:user)
      .permit(:username, :name, :email, :password, :password_confirmation)
  end
end
