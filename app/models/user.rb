class User < ApplicationRecord
  has_secure_password
  has_many :ideas
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :alias, presence: true

  before_save :email_lowercase, :name_capitalize

  def email_lowercase
    email.downcase!
  end

  def name_capitalize
    name.capitalize!
  end
end
