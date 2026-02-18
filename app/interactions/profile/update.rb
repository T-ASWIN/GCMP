class Profile::Update < ActiveInteraction::Base
    object :user
    hash :user_attributes, strip: false

    def execute
      user.assign_attributes(user_attributes)

      unless user.save
        errors.merge!(user.errors)
      end

      user
    end
  end