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

    context 'when a validation error' do
      before do
        payload[:data][:attributes] = { last_name: 'Simpson' }
      end

      it 'does not update, renders error' do
        expect {
          json_post '/api/v1/employees', payload
        }.to_not change { Employee.count }

        expect(json[0].deep_symbolize_keys).to eq({
          code: 'unprocessable_entity',
          status: '422',
          title: 'Validation Error',
          detail: "First_name can't be blank",
          source: {
            pointer: '/data/attributes/first_name'
          },
          meta: { attribute: 'first_name', message: "can't be blank" }
        })
      end
    end

    context 'when an invalid parameter' do
      before do
        payload[:data][:attributes][:age] = 'thirty'
      end

      it 'raises an error' do
        expect {
          json_post '/api/v1/employees', payload
        }.to raise_error(StrongerParameters::InvalidParameter)
      end
    end
  end
end
