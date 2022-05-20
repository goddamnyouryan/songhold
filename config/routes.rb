Rails.application.routes.draw do
  resources :playlists, only: [:index, :show, :create]
  get 'auth/spotify/callback', to: 'sessions#create'
  get 'auth/ringcentral/callback', to: 'providers#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  root 'application#home'
end
