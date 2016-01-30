class Sound < ActiveRecord::Base
  has_many :sound_tags
  has_many :images, through: :sound_tags
end
