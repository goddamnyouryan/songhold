class ProcessPlaylistJob < ApplicationJob
  queue_as :default

  def perform(user_id, playlist_id)
    @playlist = Playlist.find(playlist_id)

    # pull tracks and save them in db (so we can compare later on cron job to see if we need to pull tracks again)
    # find youtube ids for each track (should tracks be in has and belongs to many relationship, to avoid duplicating tracks, nah probably overkill right now)
    # download as wav or mp3 for each track
    # combine them all into single wav
    # upload to phone service

  end
end
