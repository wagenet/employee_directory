class SerializableEmployee < JSONAPI::Serializable::Resource
  type :employees

  attribute :first_name
  attribute :last_name
  attribute :age
  attribute :created_at
  attribute :updated_at

  has_many :positions
end
