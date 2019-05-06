class Role < ApplicationRecord
  has_many :permissions
  has_many :scopes, through: :permissions
end
