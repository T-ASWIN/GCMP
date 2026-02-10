module Users

  class StatusUpdate < ActiveInteraction::Base
  object :user
  string :status


  def execute
    return user if user.status == status

    if user.update(status: status)
      user 
    else
      errors.merge!(user.errors)
    end
  end
end

end