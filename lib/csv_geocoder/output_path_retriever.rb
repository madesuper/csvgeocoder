module CSVGeocoder
  class OutputPathRetriever
    def initialize(prompt)
      @prompt = prompt
    end

    def ask_for_output_path
      @prompt.ask("Where do you want to save the new CSV?",
        required: true,
        value: "./geocoded.csv",
        convert: :path
      )
    end
  end
end