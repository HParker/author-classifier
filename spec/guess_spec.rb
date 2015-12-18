require 'spec_helper'

RSpec.describe Gnt::Guess do
  let(:subject) { Gnt::Guess.new("greetings", 4, 0.5)}
  describe "#classification" do
    it "returns the classification" do
      expect(subject.classification).to eq("greetings")
    end
  end

  describe "#score" do
    it "returns the score" do
      expect(subject.score).to eq(4)
    end
  end

  describe "#confidence" do
    it "returns the score" do
      expect(subject.confidence).to eq(0.5)
    end
  end
end
