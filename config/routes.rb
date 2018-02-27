Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  resources :projects, only: %i[show] do
    resources :groups, only: %i[show new create]
  end

  resources :groups, only: [] do
    resources :programs, only: %i[new create]
    resources :user_groups, only: %i[create]
  end

  resources :programs, only: %i[new create] do
    resources :program_params, only: %i[create update]
    get 'tutorial', to: 'programs#tutorial'
  end
end
