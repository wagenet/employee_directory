Rails.application.routes.draw do
  scope path: '/api' do
    scope path: '/v1' do
      resources :employees, only: [:show, :index]
    end
  end
end
