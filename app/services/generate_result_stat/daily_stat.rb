# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module GenerateResultStat
  # This class is used to generate Daily Result Stat, which is instantiated by GenerateDailyResultStatsJob.
  class DailyStat
    class << self
      include Utilities

      def call(date = Date.current.iso8601)
        date = ActiveRecord::Base.connection.quote(date)
        records = fetch_daily_result_stats(date)
        if records.any?
          daily_result_stats = DailyResultStat.create(records)
          create_logs(daily_result_stats)
        else
          Rails.logger.debug(puts("No Daily Result Stats for Date #{date} have been submitted"))
        end
      end

      def fetch_daily_result_stats(date)
        sql = daily_result_stat_sql(date)
        ActiveRecord::Base.connection.execute(sql).to_a
      end

      def daily_result_stat_sql(date = 'CURRENT_TIMESTAMP')
        <<~SQL.strip_heredoc
          SELECT
            #{date}::date AS date,
            rd.subject AS subject,
            MIN(rd.marks) AS daily_low,
            MAX(rd.marks) AS daily_high,
            count(*) AS result_count
          FROM
            result_data rd
          WHERE
            timestamp
            BETWEEN
              DATE_TRUNC('day', #{date}::date)
            AND
              DATE_TRUNC('day', #{date}::date) + INTERVAL '18 hours'
          GROUP BY
            rd.subject
        SQL
      end

      def create_logs(daily_result_stats)
        return unless daily_result_stats.present?

        Rails.logger.info(puts("[#{DateTime.current}]-#{daily_result_stats.count} Daily Results have been created-"))
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
