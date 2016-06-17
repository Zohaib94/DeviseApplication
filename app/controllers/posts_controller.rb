class PostsController < ApplicationController
  before_filter :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @user = User.find(params[:user_id])
    respond_with(@post)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
    respond_with(@post)
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.new(params[:post])
    @post.user_id = @user.id
    @post.save
    redirect_to [@user , @post]
  end

  def update
    @user = User.find(params[:user_id])
    @post.update_attributes(params[:post])
    redirect_to [@user , @post]
  end

  def destroy
    @user = User.find(params[:user_id])
    @post.destroy
    redirect_to [@user , @post]
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
