JsonapiSpecHelpers::Payload.register(:employee) do
  key(:first_name, String)
  key(:last_name, String)
  key(:age, Integer)

  timestamps!
end
