module CSVGeocoder
  class OutputColumnsRetriever
    def initialize(prompt)
      @prompt = prompt
    end

    def ask_for_output_columns(select_options)
      @prompt.collect do
        key(:city_header).select("Please select the city header", select_options, filter: true)
        key(:region_header).select("Please select the region header", select_options, filter: true)
        key(:country_header).select("Please select the country header", select_options, filter: true)
        key(:postcode_header).select("Please select the postcode header", select_options, filter: true)
        key(:address_header).select("Please select the address header", select_options, filter: true)
      end
    end
  end
end