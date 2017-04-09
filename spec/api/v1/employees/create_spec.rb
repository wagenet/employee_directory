require 'rails_helper'

RSpec.describe 'v1/employees#create', type: :request do
  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'employees',
          attributes: { first_name: 'Joe' }
        }
      }
    end

    it 'creates the employee and renders correct response' do
      expect {
        json_post '/api/v1/employees', payload
      }.to change { Employee.count }.by(1)
      expect(Employee.last.first_name).to eq('Joe')

      expect(json_item['id']).to be_present
      expect(json_item['first_name']).to eq('Joe')
    end
  end
end
