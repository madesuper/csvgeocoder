module CSVGeocoder
  module GeocodeMethods
    class Coordinates
      def initialize(csv_headers)
        @csv_headers = csv_headers
      end

      def ask_for_required_headers(prompt)
        @lat_header = prompt.select("Please select the latitude header", @csv_headers, filter: true)
        @lng_header = prompt.select("Please select the longitude header", @csv_headers, filter: true)  
      end

      def search_string(row)
        [ row[@lat_header], row[@lng_header] ]
      end
    end
  end
end