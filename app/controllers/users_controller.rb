class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]
  before_action :find_user, only: [:show, :destroy]

  def index
    @users = User.admins
  end

  def show
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
    @user.destroy
    redirect_to movies_path, alert: "Account successfully deleted!"
  end

private

  def require_correct_user
    find_user
    redirect_to root_path unless current_user?(@user) || current_user_admin?
  end

  def user_params
    params.require(:user)
      .permit(:username, :name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by!(username: params[:id])
  end
end
