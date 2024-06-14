# frozen_string_literal: true

class MonthlyAverageStat < ApplicationRecord

  validates :date, presence: true
  validates :subject, presence: true
  validates :monthly_avg_low, presence: true, format: { with: /-?\d+(\.\d+)?/ }
  validates :monthly_avg_high, presence: true, format: { with: /-?\d+(\.\d+)?/ }
  validates :monthly_result_count_used, presence: true

  normalizes :subject, with: lambda(&:capitalize)
  normalizes :monthly_avg_low, with: ->(number) { '%.2f' % number }
  normalizes :monthly_avg_high, with: ->(number) { '%.2f' % number }
end
