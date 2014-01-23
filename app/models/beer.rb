class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating
    sum=0
    howMany=0
    ratings.each do |r|
      sum=sum+r.score
      howMany=howMany+1
    end
    sum/howMany

  end

  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end

end
