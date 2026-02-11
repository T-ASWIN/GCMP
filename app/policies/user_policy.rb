class UserPolicy < ApplicationPolicy
  # Controls access to the User Index and Create/Update actions
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
    user.admin?
  end

  def update_status?
    user.admin?
  end
end