class SlotSchedulePolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    !user.admin? && record.user_id == user.id
  end
end