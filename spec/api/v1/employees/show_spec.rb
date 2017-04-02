require 'rails_helper'

RSpec.describe 'v1/employees#show', type: :request do
  let!(:employee) { create(:employee) }

  it 'returns relevant employee' do
    get "/api/v1/employees/#{employee.id}"
    assert_payload(:employee, employee, json_item)
  end

  context 'when querying an employee that does not exist' do
    before do
      JsonapiErrorable.enable!
    end

    let(:expected) do
      {
        'errors' => [
          {
            'code'   => 'unprocessable_entity',
            'status' => '422',
            'title'  => 'Error',
            'detail' => 'Whoops! No employee found :(',
            'meta'   => {}
          }
        ]
      }
    end

    it 'renders relevant error payload' do
      get "/api/v1/employees/1"
      expect(json).to eq(expected)
    end
  end
end
