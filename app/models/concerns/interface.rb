class Interface
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def like_all_album_songs
    albums = get 'me/albums'

    limit = 20
    offset = 0
    page = 1

    debugger
    albums['items'].map(&:album).each do |album|
      tracks = all_tracks(album)
    end
  end

  def all_tracks(album)
    debugger
  end

  def get(uri, params = {})
    response = HTTParty.get("https://api.spotify.com/v1/#{uri}", headers: headers, params: params)
    JSON.parse(response.body)
  end

  def headers
    {
      "Authorization" => "Bearer " + token
    }
  end
end
