require 'rails_helper'

RSpec.describe "employees#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/employees/#{employee.id}", params: params
  end

  # This no longer works, and default is changed
  #before do
    #GraphitiErrors.enable!
  #end

  describe 'basic fetch' do
    let!(:employee) { create(:employee) }

    it 'works' do
      expect(EmployeeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('employees')
      expect(d.id).to eq(employee.id)
    end
  end

  describe 'when not found' do
    it 'renders correct error and status' do
      jsonapi_get "/api/v1/employees/999"
      expect(response.status).to eq(404)
      puts json.inspect
    end
  end
end
