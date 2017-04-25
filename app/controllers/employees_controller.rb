class EmployeesController < ApplicationController
  jsonapi resource: EmployeeResource

  strong_resource :employee do
    has_many :positions, destroy: true do
      belongs_to :department, destroy: true
    end
  end

  before_action :apply_strong_params, only: [:create, :update]

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

  def update
    employee, success = jsonapi_update.to_a

    if success
      render_jsonapi(employee, scope: false)
    else
      render_errors_for(employee)
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    render_jsonapi(employee, scope: false)
  end
end
