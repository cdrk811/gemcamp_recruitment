Rails.application.routes.draw do
  root to: 'batch_applicants#index', as: :user_root
  devise_for :users, path: :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :batch_applicants, only: %i[new create edit update] do
    resources :call_logs, only: %i[create update]
  end
  resources :applicants, except: :show do
    resources :batches, only: :index, controller: 'applicants/batches'
  end
  resources :batches, except: :show
end
