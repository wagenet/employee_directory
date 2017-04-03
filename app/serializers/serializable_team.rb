class SerializableTeam < JSONAPI::Serializable::Resource
  type :teams

  attribute :name
end
