class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_unless_ringcentral

  def index
    @playlists = Spotify.new(current_user).playlists
  end

  def create
    @playlist = current_user.playlists.create playlist_params

    redirect_to playlist_confirmation_path(@playlist.uid)
  end

  def show
    @playlist = Spotify.new(current_user).playlist(params[:id])
    @tracks = @playlist['tracks']['items'].map {|item| item['track']}
  end

  def confirmation
    @playlist = Spotify.new(current_user).playlist(params[:playlist_id])
  end

  private

  def playlist_params
    params.permit(:uid)
  end

  def redirect_unless_ringcentral
    redirect_to providers_path unless current_user.ringcentral && current_user.ringcentral.current?
  end
end
