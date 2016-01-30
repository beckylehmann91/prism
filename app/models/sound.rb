class Sound < ActiveRecord::Base
  has_many :sound_tags
  has_many :posts, through: :sound_tags
end
