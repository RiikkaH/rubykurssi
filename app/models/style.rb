class Style < ActiveRecord::Base


  has_many :beers

  def to_s
    "#{name}"
  end

  def self.top(n)
    #on laskettava tyyleittäin parhaat arvosanat
    styles=Rating.all.group_by{ |rating| rating.beer.style }
    #lasketaan keskiarvot tyyleittäin listaan
    average_ratings=Hash.new
    styles.each do |style, rating|
      sum= rating.inject(0){ |sum, rating| sum+rating.score } / rating.count
      average_ratings[style]=sum
    end
    #järjestetään laskevaan järjestykseen ja palautetaan ensimmäiset n
    #palautetaan siis hash, jossa style->integer
    Hash[average_ratings.sort_by { |style, age| age }.reverse .first n]
  end


end
