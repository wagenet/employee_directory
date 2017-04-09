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
end
