class SerializableEmployee < JSONAPI::Serializable::Resource
  type :employees

  attribute :first_name
  attribute :last_name
  attribute :age do
    NumbersInWords.in_words(@object.age)
  end
  attribute :created_at
  attribute :updated_at
end
