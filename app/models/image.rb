 class Image < ActiveRecord::Base
  mount_uploader :filename, FileUploader
  belongs_to :post
  has_many :colors

  before_save :h_w

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
    luminence_values
    # length = luminence_values.length
    # return ((((luminence_values.reduce(:+))/length)/ 255) * 10).ceil
  end

  def measure_luminence
    luminence = self.luminence
    length = luminence.length
    return ((((luminence.reduce(:+))/length)/ 255) * 10).ceil
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
    contrast = self.luminence.sort.reverse!
    p contrast
    contrast = ((contrast.first + 0.05)/(contrast.last + 0.05))

    if contrast >= 5.5
      return 10
    elsif contrast >= 5 && contrast < 5.5
      return 9
    elsif contrast >= 4.5 && contrast < 5
      return 8
    elsif contrast >= 4 && contrast < 4.5
      return 7
    elsif contrast >= 3.5 && contrast < 4
      return 6
    elsif contrast >= 3 && contrast < 3.5
      return 5
    elsif contrast >= 2.5 && contrast < 3
      return 4
    elsif contrast >= 2 && contrast < 2.5
      return 3
    elsif contrast >= 1.5 && contrast < 2
      return 2
    else return 1
    end

  end

  def color_variety
    (((self.convert_to_canvas.palette.length).to_f/(self.height * self.width).to_f) * 10).ceil
  end
end





