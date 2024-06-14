# frozen_string_literal: true

# This is utility class to hold utility methods so that DRY could be followed
module Utilities
  def third_monday(date)
    monthly_mondays = (date.beginning_of_month..date.end_of_month).select(&:monday?)
    monthly_mondays[2]
  end

  def get_collection_result_count(collection)
    collection.sum { |fragment| fragment['result_count'] }
  end
end
