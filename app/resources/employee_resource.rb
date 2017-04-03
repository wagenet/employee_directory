class EmployeeResource < ApplicationResource
  type :employees

  has_many :positions,
    scope: -> { Position.all },
    foreign_key: :employee_id,
    resource: PositionResource
  has_and_belongs_to_many :teams,
    scope: -> { Team.all },
    foreign_key: { employee_teams: :employee_id },
    resource: TeamResource
end
