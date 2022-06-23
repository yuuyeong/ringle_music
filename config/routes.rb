Rails.application.routes.draw do
  devise_for :users, path: "/",
              path_names: { sign_in: :login, sign_out: :logout, registration: :users },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  
  namespace :api do
    resources :groups, only: :create do
      resources :group_memberships, only: :create
    end
  
    get '/search', to: 'search#index'
    post '/playlists', to: 'playlists#create'
    get '/playlists/:id/tracks', to: 'playlist_tracks#index'
    post '/playlists/:id/tracks', to: 'playlist_tracks#create'
    delete '/playlists/:id/tracks', to: 'playlist_tracks#destroy'
    
  end
end
