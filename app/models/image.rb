 class Image < ActiveRecord::Base
  belongs_to :user
  validates :post_id, presence: true

  mount_uploader :filename, FileUploader
  belongs_to :post
  has_many :sound_tags
  has_many :sounds, through: :sound_tags

  before_save :image_dimensions, :measure_luminence, :contrast, :color_variety, :color_dominance

  # gets image path
  def file_path
    if filename.file.respond_to?(:url)
      filename.file.url
    elsif filename.file.respond_to?(:path)
      filename.file.path
    else
      "uh-oh"
    end
  end

#grab the dimensions of a submitted image
  def image_dimensions
    canvas = self.convert_to_canvas
    self.height = canvas.height
    self.width = canvas.width
  end

  # convert to canvas object (all image colors)
  def convert_to_canvas
    file_path = self.file_path
    image = ChunkyPNG::Image.from_file(open(file_path))
    image.save(open(file_path), :best_compression)
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

  #generate average rgb values for each row of the image
  def average_attributes
    sums = self.sum_attributes
    sums.map do |row|
      row.map do |attribute|
        attribute / self.width
      end
    end
  end

  # calculate the luminence values of each row
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

  #consolidate a single luminence value for an image by averaging the row luminence data.
  def measure_luminence
    luminence = self.luminence
    length = luminence.length
    self.lum = ((((luminence.reduce(:+))/length)/ 255) * 10).ceil
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

  # get contrast ratio by finding the luminence of the brightest row and dividing it by that of the darkest row
  def contrast
    contrast = self.luminence.sort.reverse!
    contrast = ((contrast.first + 0.05)/(contrast.last + 0.05))

    if contrast >= 5.5
      self.con = 10
    elsif contrast >= 5 && contrast < 5.5
      self.con = 9
    elsif contrast >= 4.5 && contrast < 5
      self.con = 8
    elsif contrast >= 4 && contrast < 4.5
      self.con = 7
    elsif contrast >= 3.5 && contrast < 4
      self.con = 6
    elsif contrast >= 3 && contrast < 3.5
      self.con = 5
    elsif contrast >= 2.5 && contrast < 3
      self.con = 4
    elsif contrast >= 2 && contrast < 2.5
      self.con = 3
    elsif contrast >= 1.5 && contrast < 2
      self.con = 2
    else
      self.con = 1
    end

  end

#divide the number of unique colors in the image by the number of pixels in the image.
  def color_variety
    self.var = (((self.convert_to_canvas.palette.length).to_f/(self.height * self.width).to_f) * 10).ceil
  end

#sum the rgb values for all rows of the image and find the most common rgb value.
  def color_dominance
    red = 0
    green = 0
    blue = 0
    array = self.average_attributes
    array.each do |row|
      red += row[0]
      green += row[1]
      blue += row[2]
    end

    if red > green && red > blue
      self.color_dom = 3
    elsif green > blue && green > red
      self.color_dom = 2
    elsif blue > green && blue > red
      self.color_dom = 1
    elsif red == green
      self.color_dom = 3
    elsif blue == green
      self.color_dom = 1
    else
      self.color_dom = 1
    end
  end

  def color_name
    if self.color_dom == 1
      return "blue"
    elsif self.color_dom == 2
      return "green"
    elsif self.color_dom == 3
      return "red"
    end
  end

  def melody
    Sound.find_by(luminence: self.lum, color_dominance: self.color_dom, role: "melody")
  end

  # color variety, need to add color dom
  def pad
    Sound.find_by(color_variety: self.var, color_dominance: self.color_dom, role: "pad")
  end

  def percussion
    Sound.find_by(contrast: self.con, role: "percussion")
  end

  def sound_set
    [self.melody, self.pad, self.percussion]
  end

  def sound_urls
    self.sound_set.map { |sound| sound.filename }
  end
end





