# frozen_string_literal: true

require_relative "csv_geocoder/version"

module CSVGeocoder
  def self.run
    CLI.new.run
  end
end
