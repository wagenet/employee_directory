class EmployeesController < ApplicationController
  jsonapi resource: EmployeeResource

  register_exception ActiveRecord::RecordNotFound,
    status: 422,
    message: ->(e) { "Whoops! No employee found :(" }

  def index
    render_jsonapi(Employee.all)
  end

  def show
    scope = jsonapi_scope(Employee.where(id: params[:id]))
    employee = scope.resolve.first
    raise ActiveRecord::RecordNotFound unless employee
    render_jsonapi(employee, scope: false)
  end
end
