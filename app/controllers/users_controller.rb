class UsersController < ApplicationController
  
  def new
    @user = User.new # is this still necessary?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to alphablog #{@user.username}"
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account has been successfully updated!"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
