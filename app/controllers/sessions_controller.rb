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

    user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.username = auth['info']['first_name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
    if user.valid?
      session[:user_id] = user.id
      redirect_to posts_path
    else
      flash[:message] = user.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end


  private
  
  def auth
    request.env['omniauth.auth']
  end


end
