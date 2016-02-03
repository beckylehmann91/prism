class Post < ActiveRecord::Base
  has_many :images
  accepts_nested_attributes_for :images
  belongs_to :user

  # validate :has_images
  validates :title, presence: true

  def has_images
    if self.images.length == 0
      errors.add(:title, "post must have an image")
    end
  end
end
