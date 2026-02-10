module Users
  class UserUpdate < ActiveInteraction::Base
    object :user
    hash :user_attributes, strip: false

    def execute
      user.assign_attributes(user_attributes)

      if user.save
        user
      else
        errors.merge!(user.errors)
        user
      end
    end
  end
end