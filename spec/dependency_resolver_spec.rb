# frozen_string_literal: true

require "spec_helper"
require "dependency_resolver"

RSpec.describe DependencyResolver do
  it { is_expected.to respond_to(:resolve) }

  describe "#resolve" do
    context "given a valid list of dependencies" do
      it "returns a comma-separated string of sorted dependencies" do
        list = ["KittenService: CamelCaser", "CamelCaser: "]

        sorted_list = described_class.new.resolve(list)

        expect(sorted_list).to eq "CamelCaser, KittenService"
      end
    end
  end
end
