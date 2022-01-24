class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = interface_request('playlists')
  end

  def show
    @playlist = interface_request('playlist', params[:id])
    @tracks = @playlist['tracks']['items'].map {|item| item['track']}
  end

  private

  def interface_request(method, arg = nil)
    interface = Interface.new(current_user.token, current_user.refresh)
    if arg
      interface.send(method, arg)
    else
      interface.send(method)
    end
  rescue Interface::ExpiredToken
    token = interface.extend_token!
    current_user.update token: token
    retry if token.present?
  end
end
