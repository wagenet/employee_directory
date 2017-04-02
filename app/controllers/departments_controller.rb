class DepartmentsController < ApplicationController
  jsonapi resource: DepartmentResource

  def index
    render_jsonapi(Department.all)
  end
end
