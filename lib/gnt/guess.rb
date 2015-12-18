module Gnt
  class Guess
    attr_reader :classification, :score, :confidence
    def initialize(classification, score, confidence)
      @classification = classification
      @score = score
      @confidence = confidence
    end
  end
end
