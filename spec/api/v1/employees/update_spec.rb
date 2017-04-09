require 'rails_helper'

RSpec.describe 'v1/employees#update', type: :request do
  describe 'basic update' do
    let!(:employee) { create(:employee, first_name: 'Joe') }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: { first_name: 'Jane', last_name: 'Simpson', age: '32' }
        }
      }
    end

    it 'updates the attributes and renders the object' do
      expect {
        json_put "/api/v1/employees/#{employee.id}", payload
      }.to change { employee.reload.first_name }.from('Joe').to('Jane')
    end
  end

  describe 'nested update' do
    def create_position
      create :position,
        employee_id: employee.id,
        department_id: department.id
    end

    let!(:employee)   { create(:employee, first_name: 'Joe') }
    let!(:position)   { create_position }
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: { first_name: 'updated' },
          relationships: {
            positions: {
              data: [
                { type: 'positions', id: position.id.to_s, method: 'update' }
              ]
            }
          }
        },
        included: [
          {
            type: 'positions',
            id: position.id.to_s,
            attributes: { title: 'updated' },
            relationships: {
              department: {
                data: { type: 'departments', id: department.id.to_s, method: 'update' }
              }
            }
          },
          {
            type: 'departments',
            id: department.id.to_s,
            attributes: { name: 'updated' }
          }
        ]
      }
    end

    it 'updates all objects' do
      json_put "/api/v1/employees/#{employee.id}", payload
      [employee, position, department].each(&:reload)
      expect(employee.first_name).to eq('updated')
      expect(position.title).to eq('updated')
      expect(department.name).to eq('updated')
    end
  end
end
