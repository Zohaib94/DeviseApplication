class PostsController < ApplicationController
  before_filter :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user = User.find(params[:user_id])
    if @user.id == current_user.id
      @posts = @user.posts
      respond_with(@posts)
    else
      redirect_to user_posts_path(current_user.id) , :notice => 'You can not access posts by other users'
    end
  end

  def show
    @user = User.find(params[:user_id])
    if @user.id == current_user.id
      respond_with(@post)
    else
      redirect_to user_posts_path(current_user.id) , :notice => 'You can not view posts by other users'
    end
  end

  def new
    @user = User.find(params[:user_id])
    if @user.id == current_user.id
      @post = @user.posts.build
      respond_with(@post)
    else
      redirect_to user_posts_path(current_user.id) , :notice => 'You can not create posts for other users'
    end
  end

  def edit
    if params[:user_id] == current_user.id
      @user = User.find(params[:user_id])
    else
      redirect_to user_posts_path(current_user.id) , :notice => 'You can not edit posts by other users'
    end
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
    if params[:user_id] == current_user.id      
      @post.destroy
      redirect_to [@user , @post]
    else
      redirect_to user_posts_path(current_user.id) , :notice => 'You can not delete posts by other users'
    end

  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
