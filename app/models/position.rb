class Position < ApplicationRecord
  belongs_to :employee, optional: true
end
