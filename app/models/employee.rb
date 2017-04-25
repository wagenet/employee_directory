class Employee < ApplicationRecord
  has_one :current_position,
    -> { current },
    class_name: 'Position'
  has_many :positions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, numericality: true
end
