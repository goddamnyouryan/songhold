class AddYouTubeIdResultsPositionToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :youtube_results_position, :integer, null: false, default: 0
  end
end
