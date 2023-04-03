Rails.application.routes.draw do
  root to: 'batch_applicants#index', as: :user_root
  devise_for :users, path: :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :applicants, except: :show do
    resources :batches, only: :index, controller: 'applicants/batches'
  end
  resources :batch_applicants, only: %i[new create edit update] do
    resources :call_logs, only: %i[create update]
    member do
      put :pass
      put :decline
      put :fail
    end
  end
  resources :batches, except: :show
  resources :pre_class_schedules, only: %i[index edit update] do
    member do
      put :confirm
      put :decline
    end
  end
end
