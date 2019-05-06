require 'rails_helper'

RSpec.describe "roles#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/roles/#{role.id}", payload
  end

  describe 'basic update' do
    let!(:role) { create(:role) }

    let(:payload) do
      {
        data: {
          id: role.id.to_s,
          type: 'roles',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(RoleResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { role.reload.attributes }
    end
  end
end
