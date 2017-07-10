# frozen_string_literal: true

class Package
  attr_reader :name, :dependency_name
  attr_accessor :dependency

  PACKAGE_ENTRY_FORMAT = /([[:word:]]+): ([[:word:]]+)?/i

  def self.build_collection_from_list(strings)
    list_hash = strings.each_with_object({}) do |entry, memo|
      name, dep_name = entry.scan(PACKAGE_ENTRY_FORMAT).flatten
      memo[name] = new(name, dep_name)
    end

    list_hash.values.each do |package|
      package.dependency = list_hash[package.dependency_name]
    end
  end

  def initialize(name, dependency_name = nil)
    @name = name
    @dependency_name = dependency_name
  end

  def ==(other)
    name == other.name
  end

  def inspect
    return name if dependency.nil?
    "#{name} <#{dependency.name}>"
  end

  def to_s
    name
  end
end
