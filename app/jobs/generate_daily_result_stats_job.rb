# frozen_string_literal: true

# This Job is used to create daily result stats at local 6 PM/ 18:00.
class GenerateDailyResultStatsJob < ApplicationJob
  include Utilities

  def perform(*_args)
    GenerateResultStat::DailyStat.call
    current_date = Date.current
    return unless current_date == monday_of_third_wednesday_week(current_date)

    GenerateResultStat::MonthlyStat.call(date)
  end
end


