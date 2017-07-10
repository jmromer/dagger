# frozen_string_literal: true

class Package
  attr_reader :name, :dependency_name
  attr_accessor :dependency

  PACKAGE_ENTRY_FORMAT = /([[:word:]]+): ([[:word:]]+)?/i

  def self.parse_list(strings:)
    strings.each_with_object([]) do |entry, memo|
      name, dep_name = entry.scan(PACKAGE_ENTRY_FORMAT).flatten
      memo << new(name, dep_name)
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
