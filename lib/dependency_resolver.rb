# frozen_string_literal: true

require "package"

class DependencyResolver
  def resolve(list)
    packages = Package.build_collection_from_list(list)

    sorted_list = packages.each_with_object([]) do |package, memo|
      memo.push(*gather_dependencies(package))
    end

    sorted_list.uniq.join(", ")
  end

  def gather_dependencies(package, list = [])
    raise CyclicDependencyError.new(package, list) if list.include?(package)

    list.unshift(package)
    return list if package.dependency.nil?

    gather_dependencies(package.dependency, list)
  end
end

class CyclicDependencyError < StandardError
  def initialize(package, dependency_list)
    message = "Package #{package} has cyclic dependencies: #{dependency_list}"
    super(message)
  end
end
