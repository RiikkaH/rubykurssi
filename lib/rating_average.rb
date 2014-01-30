module RatingAverage

  def average_rating
    sum=0
    howMany=0
    ratings.each do |r|
      sum=sum+r.score
      howMany=howMany+1
    end
   if(howMany > 0)
    sum/howMany
   else
    0
   end
  end

end
