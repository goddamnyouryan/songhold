class Playlist < ApplicationRecord
  validates :uid, presence: true
  belongs_to :user
  has_many :tracks, -> { order(position: :asc) }, dependent: :destroy

  def fetch_playlist
    Interface.new(user).playlist(uid)
  end

  def process_tracks!
    fetch_tracks!
    tracks.each {|track| track.fetch_youtube_id! }
    tracks.each {|track| track.download! }
  end

  def fetch_tracks!
    fetch_playlist['tracks']['items'].each_with_index do |track, index|
      meta = track['track']
      track = Track.find_or_initialize_by uid: meta['id']
      return track if track.persisted?
      track.assign_attributes(
        playlist: self,
        name: meta['name'],
        artist: meta['artists'].first['name'],
        position: index + 1,
      )
      track.save
    end
  end

  def merge_track_files!
    combiner = Sox::Combiner.new(tracks.map(&:download_path), combine: :concatenate)
    system 'mkdir', '-p', 'tmp/cache/playlists' # i guess sox is incapable of making dirs on its own
    combiner.write("tmp/cache/playlists/#{uid}.wav")
  end
end
