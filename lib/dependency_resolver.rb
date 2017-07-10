# frozen_string_literal: true

require "package"

class DependencyResolver
  def resolve(list)
    packages = Package.parse_list(strings: list)
    graph = build_graph(packages)

    sorted_list = graph.each_with_object([]) do |package, memo|
      memo.push(*gather_dependencies(package))
    end

    sorted_list.uniq.join(", ")
  end

  def build_graph(list)
    list.each do |package|
      dependency = list
                   .select { |dep| dep.name == package.dependency_name }
                   .first
      package.dependency = dependency
    end
  end

  def gather_dependencies(package, list = [])
    list.unshift(package)
    return list if package.dependency.nil?

    gather_dependencies(package.dependency, list)
  end
end
