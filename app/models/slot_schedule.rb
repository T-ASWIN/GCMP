class SlotSchedule < ApplicationRecord
  belongs_to :user

  enum :status, { available: 0, blocked: 1 }

  validates :date, :start_time, :end_time, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "end_time", "id", "start_time", "status", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def toggle_availability!
    available? ? blocked! : available!
  end
end