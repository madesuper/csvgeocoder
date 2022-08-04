module CSVGeocoder
  module GeocodeMethods
    class Address
      def initialize(csv_headers)
        @csv_headers = csv_headers
      end

      def ask_for_required_headers(prompt)
        @address_header = prompt.select("Please select the address header", @csv_headers, filter: true)
      end

      def search_string(row)
        row[@address_header]
      end
    end
  end
end