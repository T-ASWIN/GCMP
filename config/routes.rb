Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/update"

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

 

  resources :appointment_slots, only: [:index] do
    member do
      patch :slot_update
    end
  end

namespace :admin do
  resources :appointment_slots, only: [:index]
end
  resources :branches, only: [:index]

  resource :profile, only: [:show, :update]

  resources :gold_prices, only: [:index] do
      collection do
        post :refresh 
      end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end