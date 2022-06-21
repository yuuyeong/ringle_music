Rails.application.routes.draw do
  devise_for :users, path: "/api",
              path_names: { sign_in: :login, sign_out: :logout, registration: :users },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
end
