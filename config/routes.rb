HappyGeocode::Application.routes.draw do
  match 'map' => 'maps#index'
  match 'api_docs' => 'api_docs#index'

  root :to => 'welcome#about'
end
