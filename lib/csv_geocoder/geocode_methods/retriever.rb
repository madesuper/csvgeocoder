require_relative "address"
require_relative "coordinates"

module CSVGeocoder
  module GeocodeMethods
    class Retriever
      GEOCODE_METHODS = {
        "Latitude / Longitude": Coordinates,
        "Address": Address
      }

      def initialize(prompt)
        @prompt = prompt
      end

      def ask_for_type(csv)
        geocode_type = @prompt.select("How are we geocoding today?", GEOCODE_METHODS.keys)
        geocoder = GEOCODE_METHODS[geocode_type].new(csv.headers)
        geocoder.ask_for_required_headers(@prompt)
        geocoder
      end
    end
  end
end