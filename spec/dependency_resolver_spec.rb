# frozen_string_literal: true

require "spec_helper"
require "dependency_resolver"

RSpec.describe DependencyResolver do
  it { is_expected.to respond_to(:hello) }
end
