class SessionsController < ApplicationController
  def new
  end

  def create

    @user = User.find_or_create_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "You login"
      redirect_to posts_path
    else
      flash[:error] = "Something wrong with login"
      render 'new'
    end
  end

  def destroy

    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path

  end

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to posts_path
  end


  private
  
  def auth
    request.env['omniauth.auth']
  end


end
