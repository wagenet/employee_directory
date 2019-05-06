require 'rails_helper'

RSpec.describe ScopeResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'scopes',
          attributes: attributes_for(:scope).
            except("created_at", "updated_at")
        }
      }
    end

    let(:instance) do
      ScopeResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Scope.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:scope) { create(:scope) }

    let(:payload) do
      {
        data: {
          id: scope.id.to_s,
          type: 'scopes',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ScopeResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { scope.reload.updated_at }
      # .and change { scope.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:scope) { create(:scope) }

    let(:instance) do
      ScopeResource.find(id: scope.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Scope.count }.by(-1)
    end
  end
end
