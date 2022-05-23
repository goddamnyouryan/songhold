require 'omniauth/ringcentral'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret], scope: %w(
    playlist-read-private
    user-read-email
  ).join(' '), provider_ignores_state: true
  provider :ringcentral, Rails.application.credentials.ringcentral[:client_id], Rails.application.credentials.ringcentral[:client_secret]
end
