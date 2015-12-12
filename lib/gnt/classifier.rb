module Gnt
  class Classifier
    attr_reader :classifications

    def initialize(classifications)
      @classifications = classifications
    end

    def author_of(phrase)
      parsed_phrase = Parser.parse(phrase)
      matches = match_levels(parsed_phrase)
      best_match = matches.max_by { |_k, v| v }
      # guess object
      [best_match.first, best_match.last, confidence(best_match.last, matches)]
    end

    private

    def total
      classifications.reduce(1) { |sum, classification| sum + classification.size; sum }
    end

    def confidence(score, matches)
      (score * 1.0) / matches.values.reduce(0.0001) { |sum, score_| sum + score_ }
    end

    def match_levels(parsed_phrase)
      aggregates = Hash[classifications.map { |classification|
                          [
                           classification.classification,
                           Math.log(Rational(classification.size, total))
                          ]
                        }
                       ]

      parsed_phrase.each do |token|
        classifications.each do |classification|
          aggregates[classification.classification] += Math.log(Rational(classification.index.fetch(token, 0.1), classification.size + 1))
        end
      end
      aggregates
    end
  end
end
