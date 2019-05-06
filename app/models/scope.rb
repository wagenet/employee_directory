class Scope < ApplicationRecord
  has_many :permissions
  has_many :roles, through: :permissions
end
