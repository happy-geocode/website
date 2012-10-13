HappyGeocode::Application.routes.draw do
  match 'map' => 'maps#index'
  match 'api_docs' => 'api_docs#index'

  root :to => 'welcome#about'

  namespace :api do
    resource :geocodes, defaults: { format: :json }
  end
end
