class PostsController < ApplicationController
  include ApplicationHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    gon.sounds = sounds(@post) # return array of sounds
    @images = @post.images.all
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
        # algorithm here
        # put below in a method but create three sounds objects
        @post.sounds << Sound.create(filename: "/sounds/Strings_6_CMa_100.mp3")
        @post.sounds << Sound.create(filename: "/sounds/Piano_CMa_100.mp3")
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
