class User < ApplicationRecord
    has_secure_password

    enum :role, { user: 0, admin: 1 }, default: :user

  # Define the Status (for your Active/Inactive toggle)
  enum :status, { active: 0, inactive: 1 }, default: :active


  # Validations
  validates :email, presence: true, uniqueness: true
  validates :unique_id, presence: true, uniqueness: true
end
