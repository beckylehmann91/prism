class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
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
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
       format.html { render action: 'new' }
     end
   end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, image_attributes: [:id, :post_id, :filename])
  end

end
