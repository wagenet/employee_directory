class EmployeesController < ApplicationController
  jsonapi resource: EmployeeResource

  strong_resource :employee

  before_action :apply_strong_params, only: [:create]

  def index
    render_jsonapi(Employee.all)
  end

  def show
    scope = jsonapi_scope(Employee.where(id: params[:id]))
    render_jsonapi(scope.resolve.first, scope: false)
  end

  def create
    employee, success = jsonapi_create.to_a

    if success
      render_jsonapi(employee, scope: false)
    else
      render_errors_for(employee)
    end
  end
end
