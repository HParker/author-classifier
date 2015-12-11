module Gnt
  class Index
    attr_reader :index, :classification

    def initialize(classification)
      @classification = classification
      @index = load
    end

    def index!(parsed_corpus)
      parsed_corpus.reduce(index) { |h, word| h[word] += 1; h }
    end

    def save!
      puts "creating #{filename} index" if ENV["VERBOSE"]
      File.open("#{Constants::INDEX_DIR}/#{filename}","w") do |f|
        f.write(index.to_json)
      end
    end

    def size
      @size ||= index.values.reduce(:+)
    end

    private

    def filename
      classification.tr(' ', '_') + "-index.json"
    end

    def load
      JSON.parse(File.read("#{Constants::INDEX_DIR}/#{filename}"))
    rescue Errno::ENOENT => err
      Hash.new(0)
    end
  end
end
