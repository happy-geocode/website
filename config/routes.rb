HappyGeocode::Application.routes.draw do
  match 'map' => 'maps#index'

  root :to => 'welcome#about'
end
