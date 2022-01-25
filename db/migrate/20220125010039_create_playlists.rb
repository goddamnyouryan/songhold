class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :uid

      t.timestamps
    end
    add_index :playlists, :uid
  end
end
