Rails.application.routes.draw do
  devise_for :users, path: "/",
              path_names: { sign_in: :login, sign_out: :logout, registration: :users },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  
  namespace :api do
    resources :groups, only: :create
    resources :group_memberships, only: :create
  
    post '/playlists', to: 'playlists#create'
    post '/playlists/:id/tracks', to: 'playlist_tracks#create'
    delete '/playlists/:id/tracks', to: 'playlist_tracks#destroy'
    
  end
end
