OurnaropaCalendar::Engine.routes.draw do
  #resources :events
  
  get 'view/:date', to: 'events#index', as: :view
  
  get 'new-event', to: 'events#new'
  
  get 'event/:id', to: 'events#show', as: :event
  
  match 'new-event', to: 'events#create', as: :create_event, :via => [:post]
  
  root 'events#index', as: :events
  
end
