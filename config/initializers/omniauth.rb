OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret], scope: %w(
    playlist-read-private
    user-read-private
    user-read-email
    user-library-read
    user-follow-modify
    user-follow-read
  ).join(' '), provider_ignores_state: true
end
