require 'rails_helper'

RSpec.describe ScopeResource, type: :resource do
  describe 'serialization' do
    let!(:scope) { create(:scope) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(scope.id)
      expect(data.jsonapi_type).to eq('scopes')
    end
  end

  describe 'filtering' do
    let!(:scope1) { create(:scope) }
    let!(:scope2) { create(:scope) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: scope2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([scope2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:scope1) { create(:scope) }
      let!(:scope2) { create(:scope) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            scope1.id,
            scope2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            scope2.id,
            scope1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
