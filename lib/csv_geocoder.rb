# frozen_string_literal: true

require_relative "csv_geocoder/version"
require_relative "csv_geocoder/cli"

module CSVGeocoder
  def self.run
    CLI.new.run
  end
end
