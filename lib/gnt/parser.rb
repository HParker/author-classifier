module Gnt
  class Parser
    def self.from_files(classification, files)
      parse(corpus_for(classification, files))
    end

    def self.parse(text)
      text.split(/\W+/).map { |word| word.downcase.stem }
    end

    private

    def self.corpus_for(author, books)
      books.reduce("") { |text, book|
        text += File.readlines("#{author}/#{book}").join(" ")
      }
    end

    def self.already_indexed?(author)
      File.exist?("#{Constants::INDEX_DIR}/#{as_filename(author)}")
    end

    def self.training_books
      Constants::BOOK_LINKS
    end

    def self.as_filename(string)
      string.tr(' ', '_') + "-index.json"
    end
  end
end
