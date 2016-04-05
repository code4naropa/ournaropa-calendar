OurnaropaCalendar::Engine.routes.draw do
  resources :events, path: '/event', except: [:index, :edit, :destroy]
  
  get 'view/:date', to: 'events#index', as: :view
  
  #get 'new-event', to: 'events#new'
  
  #get 'event/:id', to: 'events#show', as: :event
  
  get 'event/:id/edit/:edit_code', to: 'events#edit', as: :edit_event
  
  match 'event/:id/delete/:edit_code', to: 'events#destroy', via: :delete, as: :delete_event
  
  #match 'event', to: 'events#create', :via => [:post]
  
  #patch 'event/:id'
  
  root 'events#index'
  
end
