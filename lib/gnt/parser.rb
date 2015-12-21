module Gnt
  # turn the strings into an array of tokens
  class Parser
    # parse takes raw text and returns a set of tokens
    # it also stems and downcases the return
    #
    # +text+ String to parse
    #
    # returns an Array of Strings
    #
    # @example
    #  Gnt::Parser.parse("Hello, how are you?) # => ['hello', 'how', 'ar', 'you']
    def self.parse(text)
      text.split(/\W+/).map { |word| word.downcase.stem }
    end
  end
end
