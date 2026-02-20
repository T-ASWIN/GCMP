class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def new?
    create?
  end

  def create?
    user.admin?
  end
  def edit?
    update?
  end

  def update?
    user.admin? || record == user
  end

  def update_status?
    user.admin?
  end
end
