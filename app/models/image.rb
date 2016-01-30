 class Image < ActiveRecord::Base
  mount_uploader :filename, FileUploader
  belongs_to :post
  has_many :colors

  # gets image path
  def file_path
    self.filename.file.file
  end

  def image_height
    canvas = self.convert_to_canvas
    self.height = canvas.height
  end

  def image_width
    canvas = self.convert_to_canvas
    self.width = canvas.width
  end

  # calc height and width of image
  def h_w
    self.image_height
    self.image_width
  end

  # convert to canvas object (all image colors)
  def convert_to_canvas
    file_path = self.file_path
    image = ChunkyPNG::Image.from_file(file_path)
    image.save(file_path, :best_compression)
    image
  end

  def canvas_to_array
    canvas = self.convert_to_canvas
    canvas.pixels
  end

  def convert_color_to_array
    array = self.canvas_to_array
    array.map do |color|
      ChunkyPNG::Color.to_truecolor_alpha_bytes(color)
    end
  end

  def create_rows
    array = self.convert_color_to_array
    array.each_slice(self.width).to_a
  end

  # sum all RGB values in a row
  def transpose_rows
    array = self.create_rows
    array.map do |row|
      row.transpose
    end
  end

  # take sum and divide by width of image
  def sum_attributes
    transposed_array = self.transpose_rows
    transposed_array.map do |row|
      row.map do |attribute|
        attribute.reduce(:+)
      end
    end
  end

  def average_attributes
    sums = self.sum_attributes
    sums.map do |row|
      row.map do |attribute|
        attribute / self.width
      end
    end
  end

  # take row and each RGB value and calculate luminence
  def luminence
    averages = self.average_attributes
    luminence_values = []
    averages.map do |row|
      luminence_values << (row[0] * 0.2126) + (row[1] * 0.7152) + (row[2] * 0.0722)
    end
    return luminence_values
  end

  # number of color occurances
  def count_occurrences
    array = self.convert_color_to_array
    occurrences = {}
    array.sort.uniq.each { |color| occurrences[color] = array.count(color)}
    occurrences
  end

  def create_colors
    colors_array = self.convert_to_palette
    self.colors = colors_array.map do |color|
      Color.create(r: color[0], g: color[1], b: color[2], a: color[3])
    end
  end

  # get contrast ratio
  def contrast
    contrast = self.luminence.reverse!
    contrast = ((contrast.first + 0.05)/(contrast.last + 0.05))
  end
end



