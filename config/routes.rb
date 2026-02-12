Rails.application.routes.draw do

  authenticated :user, ->(u) { u.admin? } do
    root to: "users#index", as: :admin_root
  end

  authenticated :user do
    root to: "appointment_slots#index", as: :user_root
  end
  
devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

   resources :users, only: [:index, :new, :create, :edit, :update] do
    member do
      get :is_active
      patch :update_status
    end
   end

   resources :branches do
    member do
      patch :update_status
    end
   end
  
  devise_for :users

 

  resources :appointment_slots, only: [:index]

  resources :branches, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end