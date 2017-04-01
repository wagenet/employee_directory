class EmployeesController < ApplicationController
  jsonapi resource: EmployeeResource

  def index
    render_jsonapi(Employee.all)
  end

  def show
    scope = jsonapi_scope(Employee.where(id: params[:id]))
    render_jsonapi(scope.resolve.first, scope: false)
  end
end
