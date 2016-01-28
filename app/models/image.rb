class Image < ActiveRecord::Base
  has_many :colors

  def convert_to_canvas
    image = ChunkyPNG::Image.from_file(self.filename)
    image.save(self.filename, :best_compression)
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
