require 'rails_helper'

RSpec.describe 'v1/departments#index', type: :request do
  describe 'basic get' do
    let!(:department1) { create(:department) }
    let!(:department2) { create(:department) }

    it 'lists departments' do
      get '/api/v1/departments'
      expect(json_ids(true)).to eq([department1.id, department2.id])
      assert_payload(:department, department1, json_items[0])
    end
  end
end
