class ProcessPlaylistJob < ApplicationJob
  queue_as :default

  def perform(user_id, playlist_id)
    @playlist = Playlist.find(playlist_id)
    @user = User.find(user_id)

    @playlist.process_tracks!
    @playlist.merge_track_files!

    @user.upload_hold_music @playlist.merged_file

    # notify user by email or something when its done
  end
end
