class Image < ActiveRecord::Base
  mount_uploader :filename, FileUploader
  belongs_to :post
  has_many :colors

  def file_path
    self.filename.file.file
  end

  def convert_to_canvas
    file_path = self.file_path
    image = ChunkyPNG::Image.from_file(file_path)
    image.save(file_path, :best_compression)
    image
  end

  def convert_to_palette
    palette = self.convert_to_canvas.palette
    palette.map do |color|
      ChunkyPNG::Color.to_truecolor_alpha_bytes(color)
    end
  end

  def create_colors
    colors_array = self.convert_to_palette
    self.colors = colors_array.map do |color|
      Color.create(r: color[0], g: color[1], b: color[2], a: color[3])
    end
  end

end
