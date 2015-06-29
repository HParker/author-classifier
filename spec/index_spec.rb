require 'spec_helper'

RSpec.describe Gnt::Index do
  describe "#new" do
    it 'creates a new index for a classification' do
      Gnt::Index.new("hotdogs", ['hot', 'dog', 'buns', 'mustard', 'ketchup'])
    end
  end

  describe "#save!" do
    it 'saves the index to a file' do
      index = Gnt::Index.new("hotdogs", ['hot'])
      expect(File).to receive(:open).with("indexes/hotdogs-index.json", "w")
      index.save!
    end
  end
end
