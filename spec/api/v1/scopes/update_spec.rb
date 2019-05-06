require 'rails_helper'

RSpec.describe "scopes#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/scopes/#{scope.id}", payload
  end

  describe 'basic update' do
    let!(:scope) { create(:scope) }

    let(:payload) do
      {
        data: {
          id: scope.id.to_s,
          type: 'scopes',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ScopeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { scope.reload.attributes }
    end
  end
end
