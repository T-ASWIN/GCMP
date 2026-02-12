Rails.application.routes.draw do

  root to: "users#index"

   resources :users, only: [:index, :new, :create, :edit, :update] do
    member do
      get :is_active
      patch :update_status
    end
  end
  
  devise_for :users

 

  resources :appointment_slots, only: [:index]

  

  get "up" => "rails/health#show", as: :rails_health_check
end