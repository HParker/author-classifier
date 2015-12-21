require 'spec_helper'

RSpec.describe Gnt::Classifier do
  let(:greetings) do
    i_ = Gnt::Classification.new('greetings')
    i_.index!('hi hello there what up.')
    i_
  end

  let(:fairwells) do
    i_ = Gnt::Classification.new('fairwells')
    i_.index!('bye later see ya')
    i_
  end

  let(:classifier) { Gnt::Classifier.new([greetings, fairwells]) }

  describe '#identify' do
    it 'returns the more likely match' do
      result = classifier.identify('why hello')
      expect(result.name).to eq('greetings')
    end

    it 'can take a custom parser' do
      class CustomParser
        def self.parse(_text)
          %w(foo foo).each_cons(1)
        end
      end

      result = classifier.identify('foo', parser: CustomParser)
      expect((result.confidence - 0.5).abs).to be < 0.01
    end
  end

  describe '#guesses' do
    it 'returns all of the matches in sorted order' do
      guesses = classifier.guesses("hello friend").map { |guess| guess.name }
      expect(guesses).to eq(['greetings', 'fairwells'])
    end
  end
end
