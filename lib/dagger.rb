# frozen_string_literal: true

module Dagger
  # Coordinator: resolves dependencies, provided in an Array of Strings
  class DependencyResolver; end

  # Model: Wraps a given package and links to its dependency, if any
  class Package; end

  # Model: Provides an ordered set implementation used to build the package
  # manifest
  class PackageList; end
end

require "dagger/package"
require "dagger/package_list"
require "dagger/dependency_resolver"
