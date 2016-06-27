class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, absence: true, on: :create
  validates :address, allow_blank: true, length: { maximum: 50 }, on: :update
  validates :bio, absence: true, on: :create
  validates :bio, allow_blank: true, length: { maximum: 50 }, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
end
