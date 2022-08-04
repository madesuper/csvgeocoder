module CSVGeocoder
  class GeocodeResult
    def initialize(result)
      @result = result
    end

    def address
      [
        "#{@result.house_number} #{@result.street}".strip,
        @result.village,
        @result.town
      ].select{|res| res }.join(", ")
    end

    def city
      @result.city
    end

    def region
      @result.state || @result.county || @result.suburb || @result.neighbourhood
    end

    def country
      @result.country
    end

    def postcode
      @result.postal_code
    end
  end
end