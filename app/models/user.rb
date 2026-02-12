class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  belongs_to :branch, optional: true
  has_many :slot_schedules, dependent: :destroy
  
  enum :role, { user: 0, admin: 1 }, default: :user

  # Define the Status (for your Active/Inactive toggle)
  enum :status, { active: 0, inactive: 1 }, default: :active

  scope :userData, -> { order(created_at: :desc) }

  # Validations
  validates :email, presence: true, uniqueness: true
  # validates :unique_id, presence: true, uniqueness: true
end
