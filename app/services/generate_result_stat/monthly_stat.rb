# frozen_string_literal: true

INVOCATION = 'ruby'
MINIMUM_INDEX ||= 5
MINIMUM_RESULT_COUNT ||= 200
MONTHLY_AVERAGE_KEYS ||= %w[date subject monthly_avg_low monthly_avg_high monthly_result_count_used].freeze

module GenerateResultStat
  # This class is used to generate Monthly Result Stat, whenever today is third Monday of the current month.
  class MonthlyStat
    class << self
      include Utilities

      def call(date)
        # NOTE: Here are two Separate paradigms followed for fetching results using Ruby and SQL.
        # By default Ruby Invocation, i.e. Data Manipulation in this scenario would be performed using Rails way.
        # In SQL Invocation, The data is fetched directly using PostgreSQL query.
        # One of them could be used as per preference!
        current_month_wednesday = Date.parse(date)
        previous_month_wednesday = monday_of_third_wednesday_week(current_month_wednesday - 1.months)
        if INVOCATION.downcase == 'ruby'
          GenerateResultStat::MonthlyResultStat::RubyInvocation.new(previous_month_wednesday, current_month_wednesday).call
        else
          GenerateResultStat::MonthlyResultStat::SqlInvocation.new(previous_month_wednesday, current_month_wednesday).call
        end
      end
    end
  end
end
