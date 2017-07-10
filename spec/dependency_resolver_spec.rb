# frozen_string_literal: true

require "spec_helper"
require "dependency_resolver"

RSpec.describe DependencyResolver do
  it { is_expected.to respond_to(:resolve) }

  describe "#resolve" do
    context "given a list with a single dependency" do
      it "returns a comma-separated string of sorted dependencies" do
        list = ["KittenService: CamelCaser", "CamelCaser: "]

        sorted_list = described_class.new.resolve(list)

        expect(sorted_list).to eq "CamelCaser, KittenService"
      end
    end

    context "given a list with multiple dependencies" do
      it "returns a comma-separated string of sorted dependencies" do
        list = ["KittenService: ",
                "Leetmeme: Cyberportal",
                "Cyberportal: Ice",
                "CamelCaser: KittenService",
                "Fraudstream: Leetmeme",
                "Ice: "]

        sorted_list = described_class.new.resolve(list)

        expect(sorted_list).to eq %w(KittenService
                                     Ice
                                     Cyberportal
                                     Leetmeme
                                     CamelCaser
                                     Fraudstream).join(", ")
      end
    end
  end
end
