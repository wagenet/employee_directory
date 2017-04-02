require 'rails_helper'

RSpec.describe 'v1/positions#index', type: :request do
  describe 'basic get' do
    let!(:position1) { create(:position) }
    let!(:position2) { create(:position) }

    it 'lists positions' do
      get '/api/v1/positions'
      expect(json_ids(true)).to eq([position1.id, position2.id])
      assert_payload(:position, position1, json_items[0])
    end
  end
end
