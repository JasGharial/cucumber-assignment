class ResultData < ApplicationRecord
  validates :subject, presence: true
  validates :timestamp, presence: true
  validates :marks, presence: true

  normalizes :subject, with: lambda(&:capitalize)
end
