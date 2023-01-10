Rails.application.routes.draw do
  root to: 'home#index', as: :user_root
  devise_for :users, path: :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :applicants, except: :show
end
