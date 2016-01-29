class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html {redirect_to @image, notice: "Image successfully created."}
        format.json { render :show, status: :created, location: @image}
      else
        format.html {render :new}
        format.json {render json: @image. errors, status: :unprocessable_entity}
      end
    end
  end

  def update
  respond_to do |format|
    if @image.update(image_params)
      format.html { redirect_to @image.post, notice: 'Image was successfully updated.' }
    end
  end
end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image destroyed"}
      format.json {head :no_content}
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:post_id, :filename)
    end
end
