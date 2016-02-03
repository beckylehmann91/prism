class PostsController < ApplicationController
  include ApplicationHelper
  include PostHelper

  #Run the set_post method in the show, edit, update, and destroy paths. This prevents having to instantiate a new variable in each path.
  before_action :set_post, only: [:show, :edit, :update, :destroy]

#if you are logged in, load up the most recent 7 posts and go to the index page. Otherwise redirect to the login
  def index
    if authenticated?
      @posts = Post.first(7)
    else
      redirect_to '/login'
    end
  end

#If you are authenticated, load the post you specify. Otherwise, redirect to the index page and provide a flash message
  def show
    if authenticated?
      if @post
        @images = @post.images.all
        gon.sounds = @post.images.map { |image| image.sound_urls } # return array of sounds paths/image
      else
        flash[:notice] = "We couldn't find a post with an id of #{params[:id]}"
        redirect_to posts_path
      end
    else
      redirect_to '/login'
    end
  end

   def new
     @post = Post.new
     @image = @post.images.build
   end

#create new posts under a given logged in user. Redirect to the post show page if nothing goes wrong. Redirect to the new post form otherwise.
  def create
    @user = User.find(session[:user_id])
    @post = @user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        params[:images]['filename'].each do |a|
          @image = @post.images.create!(:filename => a)
        end
        format.html { redirect_to @post, notice: 'A new sound image was created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @post.update(title: params[:post][:title])
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  #private method that finds a specified post.
  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, image_attributes: [:id, :post_id, :filename])
  end

end
