class Interface
  attr_accessor :token, :refresh

  def initialize(token, refresh)
    @token = token
    @refresh = refresh
  end

  def playlists
    response = get 'me/playlists', limit: 50
    response['items']
  end

  def playlist(id)
    get "playlists/#{id}"
  end

  def get(uri, params = {})
    response = HTTParty.get("https://api.spotify.com/v1/#{uri}", headers: headers, query: params)
    if response.code == 401
      fail ExpiredToken
    else
      JSON.parse(response.body)
    end
  end

  def headers
    {
      "Authorization" => "Bearer " + token
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
	refresh_token: refresh
      },
      headers: { 'Authorization' => "Basic #{auth}" }
    }
  end

  class ExpiredToken < StandardError; end
end
