module ApplicationHelper

  def sounds(post)
    # loop through sound links and put into array
    sounds = []
    post.sounds.each do |sound|
      sounds << sound.filename
    end
    return sounds
  end

end
