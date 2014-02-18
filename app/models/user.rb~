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
    #mikä tyyli on saanut keskimäärin parhaat pisteet?
    styles=ratings.group_by{ |rating| rating.beer.style }
    greatest=0
    s=nil
    styles.each do |style, rating|
      sum= rating.inject(0){ |sum, rating| sum+rating.score } / rating.count
      if sum>greatest
        greatest=sum
        s=style
      end
    end
    s
  end

  def favorite_brewery
    return nil if ratings.empty?
    # mikä panimo on saanut keskimäärin parhaat pisteet?
    breweries=ratings.group_by{ |rating| rating.beer.brewery }
    greatest=0
    b=nil
    breweries.each do |brewery, rating|
      sum=rating.inject(0){ |sum, rating| sum+rating.score } / rating.count
      if sum>greatest
        greatest=sum
        b=brewery
      end
    end
    b
  end

end
