module Gnt
  # Gnt::Guess
  class Guess
    attr_reader :name, :score, :confidence

    def initialize(name, score, total_probability)
      @name = name
      @score = score
      @confidence = score.to_f / total_probability
    end

    protected

    def <=>(other)
      score <=> other.score
    end
  end
end
