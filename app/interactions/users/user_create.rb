class Users::UserCreate < ActiveInteraction::Base
  object :user
  hash :user_attributes, strip: false

  def execute
    # Use the new name here
    user.assign_attributes(user_attributes)

    if user.save
      user
    else
      errors.merge!(user.errors)
      user
    end
  end
end