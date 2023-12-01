Rails.application.routes.draw do
  root to: 'rooms#search'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get "users/profile" => "users#show"
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
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
    collection do
    get '/search', to: 'rooms#search'
    end
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
