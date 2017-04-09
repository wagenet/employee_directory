class PositionResource < ApplicationResource
  type :positions
  model Position

  allow_filter :title_prefix do |scope, value|
    scope.where(["title LIKE ?", "#{value}%"])
  end

  belongs_to :department,
    scope: -> { Department.all },
    foreign_key: :department_id,
    resource: DepartmentResource
end
