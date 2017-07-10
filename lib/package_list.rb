# frozen_string_literal: true

class PackageList
  def initialize
    @package_set = Set.new
    @package_list = []
  end

  def add(packages)
    Array(packages).each do |package|
      next if package_set.include?(package)

      package_set << package
      package_list << package
    end

    self
  end

  def to_a
    package_list
  end

  private

  # A Set used to track inclusion with constant-time lookup
  attr_reader :package_set

  # An Array used to keep an ordered list of packages
  attr_reader :package_list
end
