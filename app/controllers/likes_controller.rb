class LikesController < ApplicationController
  def create
    Like.create like_params
    redirect_to "/secrets"
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy if @like.user === current_user
    redirect_to "/secrets"
  end

  private
  def like_params
    params.require(:like).permit(:secret_id).merge(user: current_user)
  end

end
