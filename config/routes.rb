Rails.application.routes.draw do
  get 'reservations/index'
  get 'rservations/index'
  get 'rooms/index'
  root to: 'accounts#index'
  get 'accounts/show'
  get 'profiles/show'
  get 'profiles/edit'
  patch 'profiles/update'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users

  resources :reservations do
    collection do
      post :confirm
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :rooms
 
end