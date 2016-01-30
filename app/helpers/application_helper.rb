module ApplicationHelper

  def sounds(images)
    # loop through sound links and put into array
    sounds = []

    # loop through each image object
    images.each do |image|
      sounds << image.sounds  # push each sound set array (3 elements) into array
    end
    return sounds # return array of array of sounds
  end

  # loop through image sets and generate 3 sounds based on luminance, contrast, and color
  def generate_sounds(images)
    images.each do |image|
      image.sounds << Sound.create(filename: "sounds/ambient1.mp3")
      # image.sounds << Sound.find_by(role: "melody", luminence: image.luminence, color: image.color)
      # image.sounds << Sound.find_by(role: "pad", contrast: image.contrast)
      # image.sounds << Sound.find_by(role: "percussion", color: image.color)
    end
  end
end
