class Users::Create < ActiveInteraction::Base
  hash :user_attributes, strip: false

  def execute
    user = User.new(user_attributes)


    unless user.save
      errors.merge!(user.errors)
    end

    user
  end
end
