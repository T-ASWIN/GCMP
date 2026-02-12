class Users::Create < ActiveInteraction::Base
  hash :user_attributes, strip: false

  def execute
    user = User.new(user_attributes)

    if user.save
    else
      errors.merge!(user.errors)
    end
    user
  end
end