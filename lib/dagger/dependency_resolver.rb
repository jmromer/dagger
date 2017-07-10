# frozen_string_literal: true

module Dagger
  class DependencyResolver
    def resolve(package_list)
      packages = Package.build_collection_from_list(package_list)

      sorted_list = packages.each_with_object(PackageList.new) do |package, list|
        list.add(gather_dependencies(package))
      end

      sorted_list.to_a.join(", ")
    end

    private

    def gather_dependencies(package, deps = [])
      raise Dagger::CyclicDependencyError.new(package, deps) if deps.include?(package)

      deps.unshift(package)
      return deps if package.dependency.nil?

      gather_dependencies(package.dependency, deps)
    end
  end

  # Exception: Raised when a cyclic dependency is encountered.
  class CyclicDependencyError < StandardError
    def initialize(package, dependency_list)
      super("Package '#{package}' has cyclic dependencies: #{dependency_list}")
    end
  end
end
