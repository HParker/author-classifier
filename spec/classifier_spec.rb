require 'spec_helper'

RSpec.describe Gnt::Classifier do
  describe ".author_of" do
    it "takes a string to classify" do
      gntc = Gnt::Classifier.new
      expect(gntc.author_of("the quick brown fox jumped over the lazy dog").first).to eq("mark")
    end

    it "correctly identifies qoutes from an author" do
      gntc = Gnt::Classifier.new
      test_count = 100
      Gnt::TESTS.each do |author, books|
        puts "--- #{author}"
        books.each do |book|
          puts "---- #{book}"
          lines = 0.0
          correct = 0.0
          test_corpus = File.readlines("#{author}/#{book}")
          test_count.times do
            line = test_corpus.sample + " " + test_corpus.sample + " " + test_corpus.sample
            response = gntc.author_of(line)
            next if response == "bad sample"
            guess, confidence = response
            if author == guess
              correct += 1
            else
              puts "incorectly guessed #{guess}"
            end
            lines += 1
          end
          puts "Score: #{correct}/#{lines} = #{correct/lines}"
        end
      end
    end
  end
end
