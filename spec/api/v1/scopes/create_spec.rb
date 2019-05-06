require 'rails_helper'

RSpec.describe "scopes#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/scopes", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:scope).
        except("created_at", "updated_at")
    end
    let(:payload) do
      {
        data: {
          type: 'scopes',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ScopeResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Scope.count }.by(1)
    end
  end
end
