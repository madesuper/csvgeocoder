require "geocoder"
require_relative "../geocode_result"
module CSVGeocoder
  module Sources
    class CSVRow
      def initialize(row, geocode_method)
        @row = row
        @geocode_method = geocode_method
      end

      def geocoded_result
        return @geocoded_result if @geocoded_result
        search_result = Geocoder.search(searching_by).first
        return nil unless search_result
        @geocoded_result = GeocodeResult.new(search_result)
      end

      def update_columns!(output_columns)
        return false unless geocoded_result

        @row[output_columns[:address_header]] = geocoded_result.address
        @row[output_columns[:city_header]] = geocoded_result.city
        @row[output_columns[:region_header]] = geocoded_result.region
        @row[output_columns[:country_header]] = geocoded_result.country
        @row[output_columns[:postcode_header]] = geocoded_result.postcode
        true
      end

      def to_ary
        @row.to_ary.map(&:last)
      end

      def output_string
        return "COULDN'T GEOCODE" unless geocoded_result
        "#{geocoded_result.address}"
      end

      def searching_by
        @geocode_method.search_string(@row)
      end
    end
  end
end