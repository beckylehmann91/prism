class PostsController < ApplicationController
  include ApplicationHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = [Post.find(20)]
  end

  def show
    @post = Post.find(params[:id])
    @images = @post.images.all
    gon.sounds = @post.images.map { |image| image.sound_urls } # return array of sounds paths/image
  end

   def new
     @post = Post.new
     @image = @post.images.build
   end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        p params[:images]['filename']
         params[:images]['filename'].each do |a|
            @image = @post.images.create!(:filename => a)
            p "_______________________________"
            p @post.images[0].filename
            p "_______________________________"
          end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, image_attributes: [:id, :post_id, :filename])
  end

end
