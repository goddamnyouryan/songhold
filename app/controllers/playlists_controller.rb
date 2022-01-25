class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = Interface.new(current_user).playlists
  end

  def create
    @playlist = current_user.playlists.create playlist_params

    redirect_to playlist_path(@playlist.uid)
  end

  def show
    @playlist = Interface.new(current_user).playlist(params[:id])
    @tracks = @playlist['tracks']['items'].map {|item| item['track']}
  end

  private

  def playlist_params
    params.permit(:uid)
  end
end
