# frozen_string_literal: true

class Package
  attr_reader :name, :dependency_name
  attr_accessor :dependency

  PACKAGE_ENTRY_FORMAT = /([[:word:]]+): ([[:word:]]+)?/i

  def self.parse_list(strings:)
    strings.each_with_object([]) do |entry, memo|
      name, dep_name = entry.scan(PACKAGE_ENTRY_FORMAT).flatten
      memo << Package.new(name, dep_name)
    end
  end

  def initialize(name, dependency_name)
    @name = name
    @dependency_name = dependency_name
  end

  def inspect
    return name if dependency.nil?
    "#{name} <#{dependency_name}>"
  end

  def to_s
    name
  end
end

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
