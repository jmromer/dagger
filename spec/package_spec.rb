# frozen_string_literal: true

require "spec_helper"
require "package"

RSpec.describe Package do
  describe ".build_collection_from_list_of_strings" do
    it "returns a list of packages" do
      list = ["one: three", "two: one", "three: "]

      packages = described_class.build_collection_from_list(list)

      expect(packages).to be_an_instance_of(Array)
      expect(packages).to all(be_an_instance_of(Package))
    end

    it "returns packages in the same order as given" do
      list = ["one: three", "two: one", "three: "]

      packages = described_class.build_collection_from_list(list)

      expect(packages.map(&:name)).to eq %w(one two three)
      expect(packages.map(&:dependency_name)).to eq ["three", "one", nil]
    end

    it "sets the dependency from packages provided in the same list" do
      list = ["one: three", "two: one", "three: "]
      one = described_class.new("one", "three")
      three = described_class.new("three")

      packages = described_class.build_collection_from_list(list)

      expect(packages.map(&:name)).to eq %w(one two three)
      expect(packages.map(&:dependency)).to eq [three, one, nil]
    end

    context "given an entry with no dependency" do
      it "sets dependency_name and dependency to nil" do
        list = ["one: ", "two: ", "three: "]

        packages = described_class.build_collection_from_list(list)

        expect(packages.map(&:name)).to eq %w(one two three)
        expect(packages.map(&:dependency_name)).to eq [nil, nil, nil]
        expect(packages.map(&:dependency)).to eq [nil, nil, nil]
      end
    end
  end
end
