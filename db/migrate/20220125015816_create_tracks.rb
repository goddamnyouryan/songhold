class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.belongs_to :playlist, null: false, foreign_key: true
      t.text :uid
      t.string :name
      t.string :artist
      t.integer :position
      t.integer :length
      t.string :youtube_id

      t.timestamps
    end
    add_index :tracks, :uid
    add_index :tracks, :youtube_id
  end
end
