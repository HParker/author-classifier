module Gnt
  class NgramParser
    def initialize(grams)
      @grams = grams
    end

    def parse(text)
      text.split(/\W+/).map { |word| word.downcase.stem }.each_cons(@grams).map { |gram| gram.join(' ') }
    end
  end
end
