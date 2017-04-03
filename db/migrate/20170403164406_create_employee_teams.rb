class CreateEmployeeTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_teams do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :team, index: true

      t.timestamps
    end
  end
end
