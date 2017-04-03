class Team < ApplicationRecord
  has_many :employee_teams
  has_many :teams, through: :employee_teams
end
