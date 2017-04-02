class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :department, index: true
      t.string :title

      t.timestamps
    end
  end
end
