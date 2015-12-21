require 'spec_helper'

RSpec.describe Gnt::Parser do
  describe '.parse' do
    it 'parses a phrase into stemmed version of the words' do
      expect(Gnt::Parser.parse('Hello, how are you?')).to eq(%w(hello how ar you))
    end
  end
end
