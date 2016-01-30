class Post < ActiveRecord::Base
  has_many :images
  has_many :sound_tags
  has_many :sounds, through: :sound_tags
  accepts_nested_attributes_for :images
end
