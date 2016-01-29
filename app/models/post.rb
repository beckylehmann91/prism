class Post < ActiveRecord::Base
  has_many :images
  belongs_to :sound
  accepts_nested_attributes_for :images
end
