class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3 },
                       length: { maximum: 15 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(.*[A-Z].*[0-9].*)|(.*[0-9].*[A-Z].*)/ }

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    #mikä tyyli on saanut keskimääri parhaat pisteet?
    ratings.select()
  end

  def favorite_brewery
    return nil if ratings.empty?
    # mikä panimo on saanut keskimäärin parhaat pisteet?
  end

end
