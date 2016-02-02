require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts
  has_many :images, through: :posts

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password
end
