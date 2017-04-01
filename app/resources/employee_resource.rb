class EmployeeResource < ApplicationResource
  type :employees

  allow_filter :first_name
  allow_filter :age_gte do |scope, value|
    scope.where(['age >= ?', value])
  end

  paginate do |scope, current_page, per_page|
    scope.paginate(page: current_page, per_page: per_page)
  end

  sort do |scope, att, dir|
    if att == :first_name
      dir = 'desc' if dir == :dsc
      scope.order("upper(first_name) #{dir}")
    else
      scope.order(att => dir)
    end
  end
end
