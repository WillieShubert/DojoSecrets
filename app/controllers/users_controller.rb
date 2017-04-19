class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user[:id]
      redirect_to '/sessions/new'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/join'
    end
  end

  def show
    @user = User.find(params[:id])
    @secrets = Secret.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    user = User.find(params[:id])
    session.delete(:user_id)
    user.destroy
    redirect_to '/join'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to('/secrets') unless current_user === @user
  end

end
