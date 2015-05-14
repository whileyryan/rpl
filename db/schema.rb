# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150514222218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "week"
    t.integer  "year"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "home_points"
    t.integer  "away_points"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.integer  "rookie"
    t.integer  "retire"
    t.integer  "playing"
    t.float    "mult"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "playoffs", force: :cascade do |t|
    t.integer  "week"
    t.integer  "year"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "points", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "player_id"
    t.integer  "points"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "points", ["player_id"], name: "index_points_on_player_id", using: :btree
  add_index "points", ["season_id"], name: "index_points_on_season_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "records", ["season_id"], name: "index_records_on_season_id", using: :btree
  add_index "records", ["team_id"], name: "index_records_on_team_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "year"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "pct"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seasons", ["team_id"], name: "index_seasons_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "winners", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "winners", ["season_id"], name: "index_winners_on_season_id", using: :btree
  add_index "winners", ["team_id"], name: "index_winners_on_team_id", using: :btree

end
