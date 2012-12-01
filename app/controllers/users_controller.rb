class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def show
  end

  def create

  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
