class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :age, absence: true, on: :create
  validates :age, numericality: { only_integer: true , greater_than_or_equal_to: 0, less_than: 100 },
                                 allow_blank: true, on: :update
                                 
  validates :area, absence: true, on: :create
  validates :area, length: { in: 0..10 },
                                 allow_blank: true, on: :update
  validates :profile, absence: true, on: :create
  validates :profile, length: { in: 0..140 },
                                 allow_blank: true, on: :update
end