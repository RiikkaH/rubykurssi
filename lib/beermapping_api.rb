class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 604800) { fetch_places_in(city) } #7 päivää * 24 tuntia * 60 minuuttia * 60 sekuntia
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_place(id)
    url="http://beermapping.com/webservice/locquery/#{key}/#{id}"

    response= HTTParty.get url
    Place.new(response["bmp_locations"]["location"])

  end

  def self.key
    Settings.beermapping_apikey
  end
end
