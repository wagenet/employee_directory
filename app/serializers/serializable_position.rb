class SerializablePosition < JSONAPI::Serializable::Resource
  type :positions

  attribute :title

  belongs_to :department
end
