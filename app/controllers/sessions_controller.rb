class SessionsController < ApplicationController
  def new
  end
  
  def create
    fail
    @email = params[:email]
    @password = params[:password]
  end

  def destroy
  end
end
