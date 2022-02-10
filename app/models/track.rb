class Track < ApplicationRecord
  validates :uid, :name, :artist, :position, presence: true
  belongs_to :playlist

  def download!
    fetch_youtube_id! unless youtube_id?
    return true if File.exists?(download_path)
    puts "Downloading Youtube #{youtube_id}"
    download = YoutubeDL.download "https://www.youtube.com/watch?v=#{youtube_id}", youtube_dl_options
  rescue => e
    update youtube_results_position: youtube_results_position + 1, youtube_id: nil
    retry
  end

  def youtube_dl_options
    {
      extract_audio: true,
      audio_format: 'opus',
      audio_quality: 9,
      output: "tmp/cache/downloads/#{uid}.%(ext)s"
    }
  end

  def download_path
    "tmp/cache/downloads/#{uid}.opus"
  end

  def fetch_youtube_id!
    return youtube_id if youtube_id?
    results = YouTube.search youtube_search_term
    filtered = filter_similar_length(results)
    filtered = results if filtered.empty?
    update youtube_id: filtered[youtube_results_position]['id'], length: track_length(filtered[youtube_results_position])
  end

  def youtube_search_term
    "#{artist} #{name}"
  end

  def track_length(result)
    length.nil? ? convert_to_seconds(result) : length
  end

  def filter_similar_length(results)
    return results if length.nil?
    results.select do |result|
      duration = convert_to_seconds(result)
      duration < (length + 15) && duration > (length - 15)
    end
  end

  def convert_to_seconds(result)
    ISO8601::Duration.new(result['contentDetails']['duration']).to_seconds
  end
end
