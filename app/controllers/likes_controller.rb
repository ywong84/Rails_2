class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_correct_user, only: [:destroy]

  def create
    current_user.likes.create( like_params )
    redirect_to "/secrets"
  end
  def destroy
    like = Like.find_by( like_params )
    like.destroy
    redirect_to "/secrets"
  end
  private
  def like_params
    params.require(:like).permit(:user_id, :secret_id)
  end
end
