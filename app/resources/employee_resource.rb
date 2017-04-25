class EmployeeResource < ApplicationResource
  type :employees
  model Employee

  allow_stat total: :count

  allow_filter :first_name_prefix do |scope, value|
    scope.where(["upper(first_name) LIKE ?", "#{value.upcase}%"])
  end

  allow_filter :last_name_prefix do |scope, value|
    scope.where(["upper(last_name) LIKE ?", "#{value.upcase}%"])
  end

  sort do |scope, att, dir|
    # todo - scope.by_title(dir)...maybe even scope.by(att, dir)
    if att == :title
      scope.joins(:current_position).order("title #{dir}")
    elsif att == :name
      scope.order(last_name: dir)
    elsif att == :department_name
      scope.joins(current_position: :department).order("name #{dir}")
    else
      scope.order(att => dir)
    end
  end

  has_one :current_position,
    scope: -> { Position.current },
    foreign_key: :employee_id,
    resource: PositionResource
  has_many :positions,
    scope: -> { Position.all },
    foreign_key: :employee_id,
    resource: PositionResource
end
