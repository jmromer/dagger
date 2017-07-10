# frozen_string_literal: true

require "spec_helper"
require "package"

RSpec.describe Package do
  describe ".parse_list" do
    context "given a list with dependencies" do
      it "returns a list of Packages in the same order" do
        list = ["one: three", "two: one", "three: "]

        packages = described_class.parse_list(strings: list)

        expect(packages).to be_an_instance_of(Array)
        expect(packages).to all(be_an_instance_of(Package))
        expect(packages.map(&:name)).to eq %w(one two three)
        expect(packages.map(&:dependency_name)).to eq ["three", "one", nil]
      end
    end

    context "given an entry with no dependency" do
      it "sets dependency_name to nil" do
        list = ["one: ", "two: ", "three: "]

        packages = described_class.parse_list(strings: list)

        expect(packages).to be_an_instance_of(Array)
        expect(packages).to all(be_an_instance_of(Package))
        expect(packages.map(&:name)).to eq %w(one two three)
        expect(packages.map(&:dependency_name)).to eq [nil, nil, nil]
      end
    end
  end
end
