class Employee < ApplicationRecord
  has_many :positions
  validates :first_name, presence: true
end
