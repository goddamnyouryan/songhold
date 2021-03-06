# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_07_181201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_playlists_on_uid"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uid"
    t.string "name"
    t.string "identifier"
    t.text "token"
    t.text "refresh"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_providers_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.text "uid"
    t.string "name"
    t.string "artist"
    t.integer "position"
    t.integer "length"
    t.string "youtube_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "youtube_results_position", default: 0, null: false
    t.index ["playlist_id"], name: "index_tracks_on_playlist_id"
    t.index ["uid"], name: "index_tracks_on_uid"
    t.index ["youtube_id"], name: "index_tracks_on_youtube_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.text "token"
    t.text "refresh"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "playlists", "users"
  add_foreign_key "tracks", "playlists"
end
