require 'spec_helper'

RSpec.describe Gnt::Classifier do
  describe "#identify" do
    let(:greetings) {
      i_ = Gnt::Index.new("greetings")
      i_.index!('hi hello there what up.')
      i_
    }

    let(:fairwells) {
      i_ = Gnt::Index.new("fairwells")
      i_.index!('bye later see ya')
      i_
    }

    let(:classifier) { Gnt::Classifier.new([greetings, fairwells]) }

    it "returns the more likely match" do
      result = classifier.identify('why hello')
      expect(result.classification).to eq("greetings")
    end

    it "can take a custom parser" do
      class CustomParser
        def self.parse(text)
          ["foo", "foo"].each_cons(1)
        end
      end

      result = classifier.identify('foo', parser: CustomParser)
      expect((result.confidence - 0.5).abs).to be < 0.01
    end
  end
end
