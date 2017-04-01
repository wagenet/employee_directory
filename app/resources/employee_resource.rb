class EmployeeResource < ApplicationResource
  type :employees

  allow_filter :first_name
  allow_filter :age_gte do |scope, value|
    scope.where(['age >= ?', value])
  end
end
