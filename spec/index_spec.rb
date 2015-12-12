require 'spec_helper'

RSpec.describe Gnt::Index do
  let(:hotdog) { Gnt::Index.new("hotdogs") }

  describe '#index!' do
    it 'creates an index' do
      hotdog.index!('hi there. hi')
      expect(hotdog.index).to eq({'hi' => 2, 'there' => 1})
    end

    it 'loads existing file if available' do
      expect(File).to receive(:read).with("indexes/hotdogs-index.json") {
        { 'hi' => 100 }.to_json
      }
      expect(hotdog.index).to eq({'hi' => 100})
    end

    it 'adds to an existing index if it was loaded' do
      expect(File).to receive(:read).with("indexes/hotdogs-index.json") {
        { 'hi' => 100 }.to_json
      }
      hotdog.index!('hi')
      expect(hotdog.index).to eq({'hi' => 101})
    end
  end

  describe '#save!' do
    it 'saves the index to a file' do
      expect(File).to receive(:open).with("indexes/hotdogs-index.json", "w")
      hotdog.save!
    end
  end

  describe '#size' do
    it 'returns the total of all values' do
      corpus = 'hi there hi later'
      hotdog.index!(corpus)
      expect(hotdog.size).to eq(4)
    end
  end
end
