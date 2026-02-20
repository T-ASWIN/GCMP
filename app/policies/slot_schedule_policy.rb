class SlotSchedulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all 
      else
        scope.where(user_id: user.id) 
      end
    end
  end

  def index?
    true
  end

  def update?
    user.admin? || record.user_id == user.id
  end
end