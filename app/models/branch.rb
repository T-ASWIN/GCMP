class Branch < ApplicationRecord
    has_many :users, dependent: :nullify


enum :status, { active: "active", inactive: "inactive" }, default: :active

  validates :name, presence: true, uniqueness: true

  scope :ordered, ->{order(name: :asc)}
end
