class EmployeeResource < ApplicationResource
  type :employees
  model Employee

  has_many :positions,
    scope: -> { Position.all },
    foreign_key: :employee_id,
    resource: PositionResource

  def create(attributes)
    employee = Employee.create(attributes)
    log('Created', employee)
    employee
  end

  def update(attributes)
    employee = Employee.find(attributes[:id])
    employee.update_attributes(attributes.except(:id))
    log('Updated', employee)
    employee
  end

  def destroy(id)
    employee = Employee.find(id)
    employee.destroy
    log('Deleted', employee)
    employee
  end

  private

  def log(prefix, employee)
    Rails.logger.info "#{prefix} #{employee.first_name} Employee via API"
  end
end
