class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3 },
                       length: { maximum: 15 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(.*[A-Z].*[0-9].*)|(.*[0-9].*[A-Z].*)/ }

  has_many :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
end
