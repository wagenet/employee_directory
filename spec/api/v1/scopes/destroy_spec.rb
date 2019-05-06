require 'rails_helper'

RSpec.describe "scopes#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/scopes/#{scope.id}"
  end

  describe 'basic destroy' do
    let!(:scope) { create(:scope) }

    it 'updates the resource' do
      expect(ScopeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Scope.count }.by(-1)
      expect { scope.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
