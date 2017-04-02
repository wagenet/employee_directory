JsonapiSpecHelpers::Payload.register(:employee) do
  key(:first_name, String)
  key(:last_name, String)
  key(:age, String) { |r| NumbersInWords.in_words(r.age) }

  timestamps!
end
