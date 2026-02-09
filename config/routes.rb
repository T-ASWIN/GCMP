Rails.application.routes.draw do
  resources :appointment_slots, only: [:index]
  
  # Existing routes
  get '/users',          to: 'users#index', as: 'users'

  get  '/users/new', to: 'users#new',    as: 'new_user' # The Page
  post '/users',     to: 'users#create'                # The Action

  # Update Flow
  get   '/users/:id/edit', to: 'users#edit',   as: 'edit_user' # The Page
  patch '/users/:id',      to: 'users#update', as: 'update_user'

  get '/users/:id', to:'users#show', as:'user'


  resources :users do
    member do
      get :toggle           # The page with the checkboxes
      patch :update_status  # The action that saves the status
    end
  end
  
  # ... other routes ...

  get "up" => "rails/health#show", as: :rails_health_check
end