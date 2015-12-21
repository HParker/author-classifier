require 'spec_helper'

RSpec.describe Gnt::Guess do
  let(:subject) { Gnt::Guess.new('greetings', 4, 0.5) }
  describe '#classification' do
    it 'returns the classification' do
      expect(subject.name).to eq('greetings')
    end
  end

  describe '#score' do
    it 'returns the score' do
      expect(subject.score).to eq(4)
    end
  end

  describe '#confidence' do
    it 'returns the score' do
      expect(subject.confidence).to eq(8.0)
    end
  end

  describe 'sortable' do
    it 'sorts by score' do
      best = [
        Gnt::Guess.new('best_score', 5, 0.5),
        Gnt::Guess.new('worse_score', 2, 0.5),
        subject
      ].max
      expect(best.name).to eq('best_score')
    end
  end
end
