module Gnt
  class Parser
    def self.parse(text)
      text.split(/\W+/).map { |word| word.downcase.stem }
    end
  end
end
