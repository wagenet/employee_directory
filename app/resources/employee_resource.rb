class EmployeeResource < ApplicationResource
  type :employees

  allow_filter :first_name
end
