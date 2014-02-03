class Beer < ActiveRecord::Base
  
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  
  validates :name, length: { minimum: 1 }
  validates :style, length: { minimum: 1 }
  
  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end

end
