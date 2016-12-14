class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index #index method
    @secrets = Secret.all
    @like = Like.all
    @user = User.find(current_user.id)

  end
  def create
    @secret = Secret.create( secret_params )
    if @secret.valid?
      redirect_to "/users/#{@secret.user_id}"
    else
      flash[:error] = "Enter a secret!"
      redirect_to "/users/#{@secret.user_id}"
    end
  end
  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end
  private
  def secret_params
    params.require(:secret).permit(:content, :user_id)
  end
end
