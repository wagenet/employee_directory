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
    context 'when sideloading positions and departments' do
      let!(:employee)    { create(:employee) }
      let!(:position2)   { create(:position, employee_id: nil) }
      let!(:department1) { create(:department) }
      let!(:department2) { create(:department) }

      let!(:position1) do
        create :position,
          employee_id: employee.id,
          department_id: department1.id
      end

      let!(:position3) do
        create :position,
          employee_id: employee.id,
          department_id: department2.id
      end

      it 'returns relevant associations in response' do
        get '/api/v1/employees', params: {
          include: 'positions.department'
        }
        json_positions = json_includes('positions')
        json_departments = json_includes('departments')
        expect(json_positions.length).to eq(2)
        assert_payload(:position, position1, json_positions[0])
        assert_payload(:position, position3, json_positions[1])
        assert_payload(:department, department1, json_departments[0])
        assert_payload(:department, department2, json_departments[1])
      end
    end

    describe 'when filtering/sorting/paginating positions' do
      def create_position(title)
        create :position,
          employee_id: employee.id,
          title: title
      end

      let!(:employee)  { create(:employee) }
      let!(:position1) { create_position('product wwner') }
      let!(:position2) { create_position('devops engineer') }
      let!(:position3) { create_position('developer (junior)') }
      let!(:position4) { create_position('developer (senior)') }

      it 'filters/sorts/paginates correctly' do
        get '/api/v1/employees', params: {
          include: 'positions',
          sort: 'positions.title',
          filter: { positions: { title_prefix: 'dev' } },
          page: { positions: { size: 1, page: 2 } }
        }
        json_positions = json_includes('positions')
        expect(json_positions.length).to eq(1)
        assert_payload(:position, position3, json_positions[0])
      end
    end
  end
end
