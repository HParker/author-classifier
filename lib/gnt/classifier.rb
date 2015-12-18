module Gnt
  class Classifier
    attr_reader :classifications

    def initialize(classifications)
      @classifications = classifications
    end

    def identify(phrase, parser: Parser)
      parsed_phrase = parser.parse(phrase)
      matches = match_levels(parsed_phrase)
      best_match = matches.max_by { |_k, v| v }
      Guess.new(best_match.first, best_match.last, confidence(best_match.last, matches))
    end

    private

    def total
      classifications.reduce(1) { |sum, classification| sum + classification.size }
    end

    def confidence(score, matches)
      score.to_f / matches.values.reduce(0.0001) { |sum, match_score| sum + match_score }
    end

    def match_levels(parsed_phrase)
      classifications.each_with_object({}) do |classification, results|
        results[classification.classification] =
          (prior_probability(classification) + probability(parsed_phrase, given: classification))
      end
    end

    def prior_probability(classification)
      Math.log(classification.size.to_f / total.to_f)
    end

    def probability(parsed_phrase, given:)
      parsed_phrase.reduce(0.0) do |sum, token|
        sum + Math.log((given.index.fetch(token, 0) + 1).to_f / (given.size + 1).to_f)
      end
    end
  end
end
