require 'spec_helper'

RSpec.describe Gnt::Classifier do
  describe "#author_of" do
    let(:greetings) {
      i_ = Gnt::Index.new("greetings")
      i_.index!(['hi', 'hello', 'there', 'what up'])
      i_
    }

    let(:fairwells) {
      i_ = Gnt::Index.new("fairwells")
      i_.index!(['bye', 'later', 'see', 'ya'])
      i_
    }

    let(:classifier) { Gnt::Classifier.new([greetings, fairwells]) }

    it "returns the more likely match" do
      expect(classifier.author_of('why hello there friend')).to eq(["greetings", Rational(4, 625), 0.4961240310077519])
    end
  end
end
