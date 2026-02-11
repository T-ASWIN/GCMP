class Users::Update < ActiveInteraction::Base
    object :user
    hash :user_attributes, strip: false

    def execute
      user.assign_attributes(user_attributes)

      if user.save
      else
        errors.merge!(user.errors)
      end
      user
    end
  end
