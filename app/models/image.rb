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
    image.pixels
  end

  def most_common_value
    self.group_by(&:itself).values.max_by(&:size).first
  end

  def find_height
    canvas = self.convert_to_canvas
    canvas.height
  end

  def convert_color_to_array
    canvas = self.convert_to_canvas
    canvas.map do |color|
      ChunkyPNG::Color.to_truecolor_alpha_bytes(color)
    end
  end

  def count_occurrences
    array = self.convert_color_to_array
    occurrences = {}
    array.sort.uniq.each { |color| occurrences[color] = array.count(color)}
    occurrences
  end

  # def count_occurrences
  #   array = self.convert_color_to_array
  #   occurrences = {}
  #   counter = 1
  #   array.each_with_index do |color, index|
  #     if color == array[index + 1]
  #       counter += 1
  #     else
  #       occurrences[color] = counter
  #       counter = 1
  #     end
  #   end
  #   occurrences
  # end


  def create_colors
    colors_array = self.convert_to_palette
    self.colors = colors_array.map do |color|
      Color.create(r: color[0], g: color[1], b: color[2], a: color[3])
    end
  end

end



