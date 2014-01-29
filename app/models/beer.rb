class Beer < ActiveRecord::Base
  
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  
  validates :name, length: { minimum: 1 }
  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end

end
