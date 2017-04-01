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

  describe 'filtering' do
    context 'when filtering on first_name' do
      let!(:joe1) { create(:employee, first_name: 'Joe') }
      let!(:joe2) { create(:employee, first_name: 'Joe') }
      let!(:bob)  { create(:employee, first_name: 'Bob') }

      it 'filters correctly' do
        get '/api/v1/employees', params: {
          filter: { first_name: 'Joe' }
        }
        expect(json_ids(true)).to match_array([joe1.id, joe2.id])
      end
    end

    context 'when filtering on age' do
      let!(:young) { create(:employee, age: 59) }
      let!(:equal) { create(:employee, age: 60) }
      let!(:old)   { create(:employee, age: 61) }

      it 'filters correctly' do
        get '/api/v1/employees', params: {
          filter: { age_gte: 60 }
        }
        expect(json_ids(true)).to match_array([equal.id, old.id])
      end
    end
  end
end
