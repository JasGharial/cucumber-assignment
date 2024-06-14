# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module GenerateResultStat
  module MonthlyResultStat
    class SqlInvocation

      def initialize(previous_month_wednesday, current_month_wednesday)
        @previous_month_wednesday = previous_month_wednesday
        @current_month_wednesday = current_month_wednesday
      end

      def call
        sql_invocation
      end

      def sql_invocation
        records = fetch_recent_records
        return unless records.any?

        monthly_average_stat = MonthlyAverageStat.new(records.first)
        english_month = @current_month_wednesday.strftime('%B')
        if monthly_average_stat.save!
          Rails.logger.info(puts("[#{DateTime.current}] - Monthly Results for #{english_month} have been created-"))
        else
          Rails.logger.debug(puts("No Monthly Average Result Stats for Date #{english_month} have been submitted"))
        end
      end

      def fetch_recent_records
        raw_sql = get_monthly_average_sql(@previous_month_wednesday, @current_month_wednesday)
        ActiveRecord::Base.connection.execute(raw_sql).to_a
      end

      def get_monthly_average_sql(previous_monday, current_monday)
        previous_date = ActiveRecord::Base.connection.quote(previous_monday)
        current_date = ActiveRecord::Base.connection.quote(current_monday)
        <<~SQL
          WITH previous_month_average AS (
            SELECT
              drs.date,
              drs.subject,
              AVG(daily_low)
                OVER(ORDER BY date DESC ROWS BETWEEN
                UNBOUNDED PRECEDING AND CURRENT ROW) AS monthly_low,
              AVG(daily_high)
                OVER(ORDER BY date DESC ROWS BETWEEN
                UNBOUNDED PRECEDING AND CURRENT ROW) AS monthly_high,
              SUM(result_count)
                OVER(ORDER BY date DESC ROWS BETWEEN
              UNBOUNDED PRECEDING AND CURRENT ROW) AS monthly_sum
            FROM
              daily_result_stats drs
            WHERE
              drs.date
              BETWEEN
                DATE_TRUNC('day', #{previous_date}::date)
              AND
                DATE_TRUNC('day', #{current_date}::date)
            ORDER BY drs.id DESC
          )

          SELECT
            pma.date,
            pma.subject,
            ROUND(CAST(pma.monthly_low AS numeric), 2) AS monthly_avg_low,
            ROUND(CAST(pma.monthly_high AS numeric), 2) AS monthly_avg_high,
            pma.monthly_sum AS monthly_result_count_used
          FROM
            previous_month_average pma
          WHERE
            pma.monthly_sum >= 200
          LIMIT 1
        SQL
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
