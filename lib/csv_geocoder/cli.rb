require_relative "sources/csv"
require_relative "sources/csv_row"
require_relative "geocode_methods/retriever"
require_relative "output_path_retriever"
require_relative "output_columns_retriever"
require "tty-prompt"
require "tty-progressbar"

module CSVGeocoder
  class CLI
    def initialize
      @prompt = TTY::Prompt.new(interrupt: :exit)
    end

    def run
      @csv = Sources::CSV.new(@prompt).ask
      puts
      @prompt.say "Thanks! I now need to know where to output your CSV", color: :bold
      @output_path = OutputPathRetriever.new(@prompt).ask_for_output_path
      puts
      @prompt.say "Great! I now need to know how you would like to geocode your CSV", color: :bold
      @geocode_method = GeocodeMethods::Retriever.new(@prompt).ask_for_type(@csv)
      puts
      @prompt.say "Awesome! I now need to know where you would like me to put the geocoded columns", color: :bold
      @output_columns = OutputColumnsRetriever.new(@prompt).ask_for_output_columns(@csv.headers)
      puts
      if @prompt.yes? "Start geocoding?"
        puts
        start_geocoding
      end 
    end

    def start_geocoding
      bars = TTY::ProgressBar::Multi.new("[:bar] :percent :current/:total", style: { top: "", middle: "", bottom: ""})
      geocode_progress = bars.register(":from -> :to", total: @csv.length)

      CSV.open(@output_path, "wb") do |new_csv|
        new_csv << @csv.headers
        @csv.each.with_index do |row, row_num|

          new_row = Sources::CSVRow.new(row, @geocode_method)  
          new_row.update_columns!(@output_columns)
          new_csv << new_row.to_ary

          geocode_progress.advance(
            from: new_row.searching_by.to_s,
            to: new_row.output_string
          )
        end
      end

      puts
      @prompt.ok "Completed!"
    end
  end
end