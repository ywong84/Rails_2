class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def show
    @user = User.find(params[:id])
    @secrets = @user.secrets
  end
  def new
  end
  def create
     @user = User.create( user_params )
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:blank] = "can't be blank"
      flash[:invalid] = "invalid"
      redirect_to "/users/new"
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    User.find(params[:id]).update( user_params )
    @user = User.find(params[:id])
    redirect_to "/users/#{@user.id}"
  end

  def destroy
    @user = User.find(params[:id]).destroy
    session.clear
    redirect_to "/sessions/new"
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
