Rails.application.routes.draw do
  devise_for :users, path: "/",
              path_names: { sign_in: :login, sign_out: :logout, registration: :users },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  
  namespace :api do
    resources :groups
    resources :group_memberships
  end
end
