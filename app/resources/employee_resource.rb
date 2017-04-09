class EmployeeResource < ApplicationResource
  type :employees
  model Employee

  has_many :positions,
    scope: -> { Position.all },
    foreign_key: :employee_id,
    resource: PositionResource
end
