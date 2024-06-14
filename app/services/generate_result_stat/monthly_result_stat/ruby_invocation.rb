# frozen_string_literal: true

module GenerateResultStat
  module MonthlyResultStat
    class RubyInvocation

      def initialize(previous_month_wednesday, current_month_wednesday)
        @previous_month_wednesday = previous_month_wednesday
        @current_month_wednesday = current_month_wednesday
      end

      def call
        records = fetch_daily_result_stats
        return if records.empty?

        save_monthly_average(calculate_monthly_average(records))
      end

      def fetch_daily_result_stats
        DailyResultStat.where(date: @previous_month_wednesday..@current_month_wednesday).order(id: :desc)
      end

      def calculate_monthly_average(daily_result_stats)
        index = find_sufficient_result_index(daily_result_stats)
        monthly_average_values = calculate_monthly_average_values(daily_result_stats[0..index])
        Hash[MONTHLY_AVERAGE_KEYS.zip(monthly_average_values)]
      end

      def find_sufficient_result_index(daily_result_stats)
        daily_result_stats.each_with_index do |_, index|
          return index if daily_result_stats[0..index].sum { |result| result['result_count'] } >= MINIMUM_RESULT_COUNT
        end
        daily_result_stats.size
      end

      def calculate_monthly_average_values(results)
        low_sum = results.sum { |result| result['daily_low'].to_f }
        high_sum = results.sum { |result| result['daily_high'].to_f }
        count_sum = results.sum { |result| result['result_count'] }
        total_records = results.size
        subject = results.pluck('subject').uniq[0]

        average_low = (low_sum / total_records.to_f).round(2)
        average_high = (high_sum / total_records.to_f).round(2)

        [@current_month_wednesday.iso8601, subject, average_low, average_high, count_sum]
      end

      def save_monthly_average(monthly_average_hash)
        monthly_average_stat = MonthlyAverageStat.new(monthly_average_hash)
        english_month = @current_month_wednesday.strftime('%B')
        if monthly_average_stat.save!
          Rails.logger.info("[#{DateTime.current}] - Monthly Results for #{english_month} have been created")
        else
          Rails.logger.debug("No Monthly Average Result Stats for Date #{english_month} have been submitted")
        end
      rescue StandardError => e
        Rails.logger.error("Failed to save Monthly Average Stat: #{e.message}")
      end
    end
  end
end
