class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(params_user)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welceome #{@user.username}"
            redirect_to posts_path
        else
            render 'new'
        end
    end


    private
        def params_user
            params.require(:user).permit(:username, :email, :password)
        end
end
