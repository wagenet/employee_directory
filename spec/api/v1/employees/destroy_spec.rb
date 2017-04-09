require 'rails_helper'

RSpec.describe 'v1/employees#destroy', type: :request do
  describe 'basic destroy' do
    let!(:employee) { create(:employee) }

    it 'deletes the employee' do
      expect {
        delete "/api/v1/employees/#{employee.id}"
      }.to change { Employee.count }.by(-1)
    end
  end
end
