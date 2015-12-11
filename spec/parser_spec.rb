require 'spec_helper'

RSpec.describe Gnt::Parser do
  describe ".parse" do
    it "takes a text to parse" do
      expect(Gnt::Parser.parse("hello how are you?")).to eq( ["hello", "how", "ar", "you"])
    end
  end
end
