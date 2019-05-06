class RoleResource < ApplicationResource
  attribute :name, :string

  many_to_many :scopes
end
