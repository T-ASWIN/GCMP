Rails.application.routes.draw do
   resources :users, path: 'manage_users' do
    member do
      get :is_active
      patch :update_status
    end
  end
  
  devise_for :users

 

  resources :appointment_slots, only: [:index]

  root to: "users#index"

  get "up" => "rails/health#show", as: :rails_health_check
end