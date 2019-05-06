require 'rails_helper'

RSpec.describe "scopes#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/scopes", params: params
  end

  describe 'basic fetch' do
    let!(:scope1) { create(:scope) }
    let!(:scope2) { create(:scope) }

    it 'works' do
      expect(ScopeResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['scopes'])
      expect(d.map(&:id)).to match_array([scope1.id, scope2.id])
    end
  end
end
