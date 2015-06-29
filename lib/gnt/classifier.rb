module Gnt
  class Classifier
    def initialize(parser: Parser)
      @parser = parser
    end

    def author_of(phrase)
      parsed_phrase = parser.parse(phrase)
      return "bad sample" unless (parsed_phrase && parsed_phrase.size > 5)
      matches = match_levels(parsed_phrase)
      best_match = matches.max_by { |_k, v| v }
      # guess object
      [best_match.first, best_match.last, confidence(best_match.last, matches)]
    end

    private

    def parser
      @parser
    end

    def total
      author_indexes.values.map(&:values).flatten.reduce(&:+)
    end

    def category_total(category)
      author_indexes[category].values.reduce(&:+)
    end

    def confidence(score, matches)
      (score * 1.0) / matches.values.reduce(0.0001) { |sum, score_| sum + score_ }
    end

    def match_levels(parsed_phrase)
      aggregates = Hash[author_indexes.map { |author, index|
                          [name_from_path(author),
                           Rational(category_total(author).to_i, total.to_i)
                          ]
                        }]

      parsed_phrase.each do |token|
        author_indexes.each do |author, index|
          aggregates[author] *= Rational(index.fetch(token, 1), category_total(author).to_i + 1)
        end
      end
      aggregates
    end

    def name_from_path(path)
      File.basename(path, ".json").gsub("-index", "")
    end

    def author_indexes
      @author_indexes ||= Hash[Dir["indexes/*.json"].map { |book_path|
        [name_from_path(book_path), JSON.parse(File.readlines(book_path).join)] unless book_path == "indexes/all-index.json"
      }.compact]
    end
  end
end
