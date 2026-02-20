class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  belongs_to :branch, optional: true
  has_many :slot_schedules, dependent: :destroy

  enum :role, { user: "user", admin: "admin" }, default: "user"
  validates :role, inclusion: { in: %w[user admin] }


  enum :status, { active: "active", inactive: "inactive" }, default: "active"
  validates :status, inclusion: { in: %w[active inactive] }

  scope :userData, -> { order(created_at: :desc) }

  validates :email, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
     [ "name", "email", "id" ]
  end
end
