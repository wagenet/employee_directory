class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.belongs_to :role, foreign_key: true
      t.belongs_to :scope, foreign_key: true

      t.timestamps
    end
  end
end
