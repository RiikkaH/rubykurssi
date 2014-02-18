class Beer < ActiveRecord::Base
  
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, :dependent => :destroy
  
  validates :name, length: { minimum: 1 }
  validates :style, presence: true
  
  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end

  def self.top(n)
   sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) } 
   sorted_by_rating_in_desc_order.slice(0,n)
  end

end
