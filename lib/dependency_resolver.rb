# frozen_string_literal: true

class DependencyResolver
  PACKAGE_ENTRY_FORMAT = /([[:word:]]+): ([[:word:]]+)?/i

  def resolve(list)
    list = list.each_with_object([]) do |entry, memo|
      memo << entry.scan(PACKAGE_ENTRY_FORMAT).flatten.map(&:to_s)
    end

    sorted = list.sort_by(&:last)

    sorted.map(&:first).join(", ")
  end
end
