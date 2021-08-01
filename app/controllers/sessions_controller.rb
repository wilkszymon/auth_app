class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "You login"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy

  end

  def omniauth
    binding.pry
    # @user = User.from_omniauth(request.env['omniauth.auth'])
    # @user.save
    # session[:user_id] = @user.id
    # redirect_to root_path
  end


  private
  
  def auth
    request.env['omniauth.auth']
  end


end
