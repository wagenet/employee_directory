StrongResources.configure do
  strong_resource :employee do
    attribute :first_name, :string
    attribute :last_name, :string
    attribute :age, :integer
  end
end
