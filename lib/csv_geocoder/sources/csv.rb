require "csv"
module CSVGeocoder
  module Sources
    class CSV
      def initialize(prompt)
        @prompt = prompt
      end

      def ask
        csv = nil
        until csv
          begin
            csv_path = @prompt.ask("Hi, whats the path to your CSV?", required: true)
            csv ||= ::CSV.read(csv_path, headers: true)
          rescue Errno::ENOENT
            @prompt.error "Thats not a valid CSV path, please enter it again"
            @prompt.warn "If you're on mac, right click the file, hold option, then click copy as pathname"
          end
        end
        csv
      end
    end
  end
end