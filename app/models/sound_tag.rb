class SoundTag < ActiveRecord::Base
  belongs_to :sound
  belongs_to :post
end
