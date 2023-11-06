Rails.application.routes.draw do
  
  root to: 'homes#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'users/account', to: 'users/registrations#show',as: 'account_show'
    get 'users/edit', to: 'users/registrations#edit',as: 'account_edit'
    patch 'users/account', to: 'users/registrations#update',as: 'account_update'
    get 'users/profile', to: 'users/registrations#profile_show', as: 'profile_show'
    get 'users/profile/edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'users/profile/update', to: 'users/registrations#profile_update', as: 'profile_update'

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

  resources :rooms do
    get :search, on: :collection
  end  
 
end