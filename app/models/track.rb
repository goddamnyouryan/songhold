class Track < ApplicationRecord
  validates :uid, :name, :artist, :position, presence: true
  belongs_to :playlist

  def fetch_youtube_id!
    results = YouTube.search youtube_search_term
    filtered = filter_similar_length(results)
    filtered = results if filtered.empty?
    update youtube_id: filtered.first['id'], length: track_length(filtered.first)
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
