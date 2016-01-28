class ColorsController < ApplicationController

  def index
    @colors = Color.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    #if logge_in
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to @post
    else
      @errors = @post.errors.full_messages
      render 'new'
    end
    #else
      #redirect
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      @errors = @post.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end