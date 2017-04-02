require 'rails_helper'

RSpec.describe 'v1/employees#index', type: :request do
  describe 'basic get' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    it 'lists employees' do
      get '/api/v1/employees'
      expect(json_ids(true)).to eq([employee1.id, employee2.id])
      assert_payload(:employee, employee1, json_items[0])
    end
  end

  describe 'sideloading' do
    context 'when sideloading positions' do
      let!(:employee)  { create(:employee) }
      let!(:position1) { create(:position, employee_id: employee.id) }
      let!(:position2) { create(:position, employee_id: nil) }
      let!(:position3) { create(:position, employee_id: employee.id) }

      it 'returns relevant positions in response' do
        get '/api/v1/employees', params: {
          include: 'positions'
        }
        json_positions = json_includes('positions')
        expect(json_positions.length).to eq(2)
        assert_payload(:position, position1, json_positions[0])
        assert_payload(:position, position3, json_positions[1])
      end
    end
  end
end
