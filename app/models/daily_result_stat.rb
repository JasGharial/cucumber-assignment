# frozen_string_literal: true

class DailyResultStat < ApplicationRecord

  validates :date, presence: true
  validates :subject, presence: true
  validates :daily_low, presence: true, format: { with: /-?\d+(\.\d+)?/ }
  validates :daily_high, presence: true, format: { with: /-?\d+(\.\d+)?/ }
  validates :result_count, presence: true

  normalizes :subject, with: lambda(&:capitalize)
  normalizes :daily_low, with: ->(number) { '%.2f' % number }
  normalizes :daily_high, with: ->(number) { '%.2f' % number }
end
