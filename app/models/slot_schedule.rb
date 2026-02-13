class SlotSchedule < ApplicationRecord
  belongs_to :user

  # Matches your UI logic
  enum :status, { available: 0, blocked: 1 }

  validates :date, :start_time, :end_time, presence: true

def self.ransackable_attributes(auth_object = nil)
    ["date", "start_time", "end_time", "status", "user_id", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end