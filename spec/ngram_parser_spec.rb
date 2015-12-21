require 'spec_helper'

RSpec.describe Gnt::NgramParser do
  describe '.parse' do
    it 'parses into word pairs' do
      parser = Gnt::NgramParser.new(2)
      expect(parser.parse('hello how are you?').to_a).to eq(['hello how', 'how ar', 'ar you'])
    end
  end
end
