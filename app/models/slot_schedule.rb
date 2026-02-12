class SlotSchedule < ApplicationRecord
  belongs_to :user

  # Matches your UI logic
  enum :status, { available: 0, blocked: 1 }

  validates :date, :start_time, :end_time, presence: true
end