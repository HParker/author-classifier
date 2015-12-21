module Gnt
  # represents a category of text.
  class Classification
    attr_reader :index, :name

    # creates a new classification
    #
    # +name+ the name of a classification
    #
    # will attempt to load a index from your specified
    # index directory if the file exists
    def initialize(name)
      @name = name
      @index = load
    end

    # creates an index representing this classification
    #
    # +corpus+ a set of text used to train the classification
    #
    # +parser:+ you can also optionally pass a custom parser
    #
    #  classification.index!("hello how are you")
    def index!(corpus, parser: Parser)
      parser.parse(corpus).reduce(index) { |h, word| h[word] += 1; h }
    end

    # +save!+ dumps a +json+ representation of the index into your +GNT_INDEX_DIR+
    #
    #  classification.save!
    def save!
      puts "creating #{filename} index" if ENV['VERBOSE']
      File.open("#{Constants::INDEX_DIR}/#{filename}", 'w') do |f|
        f.write(index.to_json)
      end
    end

    # returns the number of words in your training data
    def size
      @size ||= index.values.reduce(:+)
    end

    private

    def filename
      name.tr(' ', '_') + '-index.json'
    end

    def load
      Hash.new(0).merge(JSON.parse(File.read("#{Constants::INDEX_DIR}/#{filename}")))
    rescue Errno::ENOENT, JSON::ParserError
      Hash.new(0)
    end
  end
end
