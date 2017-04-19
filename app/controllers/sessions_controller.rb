class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index, :login]
  def index
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = ["user logged in"]
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = ['Invalid Combination']
      redirect_to '/sessions/new'
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to '/sessions/new'
  end

end
