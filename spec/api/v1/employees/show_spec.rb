require 'rails_helper'

RSpec.describe 'v1/employees#show', type: :request do
  let!(:employee) { create(:employee) }

  it 'returns relevant employee' do
    get "/api/v1/employees/#{employee.id}"
    assert_payload(:employee, employee, json_item)
  end
end
