class PostsController < ApplicationController

  require 'uri'
  require 'net/http'
  require 'json'
  require 'openssl'

  before_action :require_user 
  before_action :set_post, only:[:edit, :destroy, :update]
  before_action :require_same_user, only:[:edit, :destroy, :update]

  def index
    @posts = current_user.posts
    @post = Post.new
    
  end    

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params_post)
    @post.user_id = current_user.id
    @post.weather = Post.from_API(params[:post][:city])
    
    if @post.save
      redirect_to posts_path
    else
      flash[:message] = @post.errors.full_messages.join(", ")
      redirect_to posts_path
    end
  end

  def edit
  end

  def update
    if @post.update(params_post)
      flash[:notice] = "Update a post"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Deleted"
    redirect_to posts_path
  end

  private

    def params_post
      params.require(:post).permit(:city, :description)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def require_same_user
      if @post.user_id != current_user.id
        flash[:notice] = "You can only edit or deleted your own post"
        redirect_to posts_path
      end
    end

end
