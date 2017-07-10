# frozen_string_literal: true

require "spec_helper"
require "package_list"

RSpec.describe PackageList do
  it { is_expected.to respond_to(:add) }

  describe "#add" do
    it "accepts single entries" do
      list = described_class.new

      list.add(1)
      list.add(2)
      list.add(3)

      expect(list.to_a).to eq [1, 2, 3]
    end

    it "accepts an array of entries" do
      list = described_class.new

      list.add([1, 2, 3])

      expect(list.to_a).to eq [1, 2, 3]
    end

    it "adds entries idempotently" do
      list = described_class.new

      list.add(1)
      list.add(1)

      expect(list.to_a).to eq [1]
    end

    it "maintains insertion order" do
      list = described_class.new

      list.add([5, 1, 2, 3])
      list.add([2, 3, 4])

      expect(list.to_a).to eq [5, 1, 2, 3, 4]
    end
  end
end
