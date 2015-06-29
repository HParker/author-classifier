module Gnt
  class Index
    def self.build_all
      Constants::BOOK_LINKS.each do |classification, training_sets|
        create!(classification, Parser.from_files(classification, training_sets))
      end
    end

    def self.create!(classification, parsed_corpus)
      new(classification, parsed_corpus).save!
    end

    def initialize(classification, parsed_corpus)
      @classification = classification
      @index = index(parsed_corpus)
    end

    def save!
      unless already_indexed?(@classification)
        puts "creating #{@classification}-index" if ENV["VERBOSE"]
        File.open("#{Constants::INDEX_DIR}/#{@classification}-index.json","w") do |f|
          f.write(@index.to_json)
        end
      end
      self
    end

    private

    def index(parsed_corpus)
      parsed_corpus.reduce(Hash.new(0)) { |h, word| h[word] += 1; h }
    end

    def already_indexed?(classification)
      File.exist?("#{Constants::INDEX_DIR}/#{as_filename(classification)}")
    end

    def as_filename(classification)
      classification.tr(' ', '_') + "-index.json"
    end
  end
end
