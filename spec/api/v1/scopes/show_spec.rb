require 'rails_helper'

RSpec.describe "scopes#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/scopes/#{scope.id}", params: params
  end

  describe 'basic fetch' do
    let!(:scope) { create(:scope) }

    it 'works' do
      expect(ScopeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('scopes')
      expect(d.id).to eq(scope.id)
    end
  end
end
