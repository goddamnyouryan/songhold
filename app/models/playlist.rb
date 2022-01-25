class Playlist < ApplicationRecord
  validates :uid, presence: true
  belongs_to :user
  has_many :tracks, dependent: :destroy

  def fetch_playlist
    Interface.new(user).playlist(uid)
  end

  def process_tracks!
    fetch_tracks!
    tracks.each {|track| track.fetch_youtube_id! }
  end

  def fetch_tracks!
    fetch_playlist['tracks']['items'].each_with_index do |track, index|
      meta = track['track']
      Track.create(
        playlist: self,
        uid: meta['id'],
        name: meta['name'],
        artist: meta['artists'].first['name'],
        position: index + 1,
      )
    end
  end
end
