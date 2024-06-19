# frozen_string_literal: true

# This is utility class to hold utility methods so that DRY could be followed
module Utilities
  def third_monday(date)
    # This function returns the Monday of the week on which the third wednesday of the month of which the date parameter is passed.
    monthly_mondays = (date.beginning_of_month..date.end_of_month).select(&:wednesday?)
    monthly_mondays[2].beginning_of_week
  end

  def get_collection_result_count(collection)
    collection.sum { |fragment| fragment['result_count'] }
  end
end
