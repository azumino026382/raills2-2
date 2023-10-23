Rails.application.routes.draw do
  root to: 'homes#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users

  resources :accounts, only: [:show, :edit, :update]

  resources :profiles, only: [:show, :edit, :update]

  resources :reservations do
    collection do
      post :confirm
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :rooms do
    get :search, on: :collection
  end  
 
end