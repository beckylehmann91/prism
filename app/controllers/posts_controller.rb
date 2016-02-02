class PostsController < ApplicationController
  include ApplicationHelper
  include PostHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if authenticated?
      @posts = Post.first(7)
    else
      redirect_to '/login'
    end
  end

  def show
    # @post = Post.find(params[:id])
    if authenticated?
      if @post
        @images = @post.images.all
        gon.sounds = @post.images.map { |image| image.sound_urls } # return array of sounds paths/image
      else
        flash[:notice] = "Couldn't find post ID# #{params[:id]}"
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

  def create
    @post = Post.new(post_params)

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
  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, image_attributes: [:id, :post_id, :filename])
  end

end
