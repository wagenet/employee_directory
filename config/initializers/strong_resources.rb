ActionController::Parameters.allow_nil_for_everything = true

StrongResources.configure do
  strong_resource :employee do
    attribute :first_name, :string
    attribute :last_name, :string
    attribute :age, :integer
  end

  strong_resource :position do
    attribute :title, :string
    attribute :historical_index, :integer
  end

  strong_resource :department do
    attribute :name, :string
  end
end
