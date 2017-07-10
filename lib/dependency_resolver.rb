# frozen_string_literal: true

require "package"
require "package_list"

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
    raise CyclicDependencyError.new(package, deps) if deps.include?(package)

    deps.unshift(package)
    return deps if package.dependency.nil?

    gather_dependencies(package.dependency, deps)
  end
end

class CyclicDependencyError < StandardError
  def initialize(package, dependency_list)
    message = "Package '#{package}' has cyclic dependencies: #{dependency_list}"
    super(message)
  end
end
