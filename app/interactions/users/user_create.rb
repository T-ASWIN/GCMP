class Users::UserCreate < ActiveInteraction::Base
  hash :user_attributes, strip: false

  def execute
    user = User.new(user_attributes)

    if user.save
      user
    else
      errors.merge!(user.errors)
      user
    end
  end
end