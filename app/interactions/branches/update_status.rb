class Branches::UpdateStatus < ActiveInteraction::Base
  object :branch
  string :status


  def execute
    return branch if branch.status == status

    if branch.update(status:)
      branch
    else
      errors.merge!(user.errors)
    end
  end
end
