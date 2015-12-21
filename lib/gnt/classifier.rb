module Gnt
  # Gnt::Classifier
  # used to identify which classification a piece of text is most similar to.
  class Classifier
    attr_reader :classifications

    # create a classifier with a list of classifications
    # +classification +Classifications+ is an array
    # @return Classifier
    def initialize(classifications)
      @classifications = classifications
    end

    # return the full list possible phrase matches
    #
    #
    #  classifier.guesses("input text") # => [<Guess>, <Guess>]
    #
    #  # with custom parser
    #  classifier.guesses("input text", parser: Gnt::NgramParser)  # => [<Guess>, <Guess>]
    #
    # +phrase+ to classify
    # @param a parser used to tokenize the text to classify
    # @return an array of [Guesses]
    def guesses(phrase, parser: Parser)
      tokens = parser.parse(phrase)
      classifications.zip(probabilities(tokens)).map { |classification, probability|
        Guess.new(classification.name, probability, total_probability(tokens))
      }.sort.reverse
    end

    # return the full list possible phrase matches
    #
    # @example
    #  classifier.identify("input text") # => <Guess>
    #
    #  # with custom parser
    #  classifier.guesses("input text", parser: Gnt::NgramParser)  # => <Guess>
    #
    # @param phrase to classify
    # @param a parser used to tokenize the text to classify
    # @return the best [Guess]
    def identify(phrase, parser: Parser)
      guesses(phrase, parser: parser).max
    end

    private

    def total
      classifications.reduce(1) do |sum, classification|
        sum + classification.size
      end
    end

    def total_probability(tokens)
      probabilities(tokens).reduce(:+) + 0.0001
    end

    def probabilities(tokens)
      classifications.map do |classification|
        (prior_probability(classification) + probability(tokens, classification))
      end
    end

    def prior_probability(classification)
      Math.log(classification.size.to_f / total.to_f)
    end

    def probability(tokens, given)
      tokens.reduce(0.0) do |sum, token|
        sum + Math.log((given.index.fetch(token, 1)).to_f / (given.size + 1))
      end
    end
  end
end
