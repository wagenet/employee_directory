class Position < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :department, optional: true

  validates :title, presence: true

  scope :current, -> { where(historical_index: 1) }
end
