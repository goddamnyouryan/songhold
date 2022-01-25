class Interface
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def playlists
    response = get 'me/playlists', limit: 50
    response['items']
  end

  def playlist(id)
    get "playlists/#{id}"
  end

  def get(uri, params = {})
    spotify_request(uri, params)
  rescue ExpiredToken
    token = extend_token!
    if token.present?
      user.update token: token
      user.reload
      retry
    end
  end

  def spotify_request(uri, params = {})
    response = HTTParty.get("https://api.spotify.com/v1/#{uri}", headers: headers, query: params)
    if response.code == 401
      fail ExpiredToken
    else
      JSON.parse(response.body)
    end
  end

  def headers
    {
      "Authorization" => "Bearer " + user.token
    }
  end

  def extend_token!
    response = HTTParty.post("https://accounts.spotify.com/api/token?refresh_token", refresh_request)
    response['access_token']
  end

  def refresh_request
    auth = Base64.strict_encode64("#{Rails.application.credentials.spotify[:client_id]}:#{Rails.application.credentials.spotify[:client_secret]}")
    {
      body: {
	grant_type: 'refresh_token',
	refresh_token: user.refresh
      },
      headers: { 'Authorization' => "Basic #{auth}" }
    }
  end

  class ExpiredToken < StandardError; end
end
