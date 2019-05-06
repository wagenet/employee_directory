require 'rails_helper'

RSpec.describe "roles#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/roles/#{role.id}"
  end

  describe 'basic destroy' do
    let!(:role) { create(:role) }

    it 'updates the resource' do
      expect(RoleResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Role.count }.by(-1)
      expect { role.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
