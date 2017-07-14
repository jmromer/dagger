# frozen_string_literal: true

require "spec_helper"
require "dagger/dependency_resolver"

module Dagger
  RSpec.describe DependencyResolver do
    it { is_expected.to respond_to(:resolve) }

    describe "#resolve" do
      context "given a list with a single dependency" do
        it "returns a comma-separated string of sorted dependencies" do
          dependencies = ["KittenService: CamelCaser", "CamelCaser: "]

          sorted_list = described_class.new.resolve(dependencies)

          expect(sorted_list).to eq "CamelCaser, KittenService"
        end
      end

      context "given a list with multiple dependencies" do
        it "returns a comma-separated string of sorted dependencies" do
          dependencies = ["KittenService: ",
                          "Leetmeme: Cyberportal",
                          "Cyberportal: Ice",
                          "CamelCaser: KittenService",
                          "Fraudstream: Leetmeme",
                          "Ice: "]

          sorted_list = described_class.new.resolve(dependencies)

          expect(sorted_list).to eq %w(KittenService
                                       Ice
                                       Cyberportal
                                       Leetmeme
                                       CamelCaser
                                       Fraudstream).join(", ")
        end
      end

      context "given cyclic dependencies" do
        it "raises an exception" do
          dependencies = ["KittenService: ",
                          "Leetmeme: Cyberportal",
                          "Cyberportal: Ice",
                          "CamelCaser: KittenService",
                          "Fraudstream: ",
                          "Ice: Leetmeme"]

          resolve = described_class.new.method(:resolve)

          expect { resolve.call(dependencies) }
            .to raise_exception(CyclicDependencyError)
        end
      end
    end
  end
end
