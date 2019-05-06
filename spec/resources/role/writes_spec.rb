require 'rails_helper'

RSpec.describe RoleResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'roles',
          attributes: attributes_for(:role).
            except("created_at", "updated_at")
        }
      }
    end

    let(:instance) do
      RoleResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Role.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:role) { create(:role) }

    let(:payload) do
      {
        data: {
          id: role.id.to_s,
          type: 'roles',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      RoleResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { role.reload.updated_at }
      # .and change { role.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:role) { create(:role) }

    let(:instance) do
      RoleResource.find(id: role.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Role.count }.by(-1)
    end
  end
end
