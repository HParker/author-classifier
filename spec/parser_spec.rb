require 'spec_helper'

RSpec.describe Gnt::Parser do
  describe "#new" do
    it "is callable" do
      Gnt::Parser.new
    end
  end

  describe ".from_files" do

  end

  describe ".parse" do
    it "takes a text to parse" do
      expect(Gnt::Parser.parse("hello how are you?")).to eq( ["hello", "how", "ar", "you"])
    end
  end
end
