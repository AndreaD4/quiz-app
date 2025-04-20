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

ActiveRecord::Schema[7.0].define(version: 2025_04_20_081735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "host"
    t.integer "users_count", default: 0
    t.integer "managers_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host"], name: "index_companies_on_host", unique: true
  end

  create_table "game_rooms", force: :cascade do |t|
    t.bigint "companies_id"
    t.string "name", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_game_rooms_on_companies_id"
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "companies_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_houses_on_companies_id"
  end

  create_table "managers", force: :cascade do |t|
    t.bigint "companies_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_managers_on_companies_id"
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.bigint "companies_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "game_room_id"
    t.bigint "house_id"
    t.string "nickname", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_players_on_companies_id"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["game_room_id"], name: "index_players_on_game_room_id"
    t.index ["house_id"], name: "index_players_on_house_id"
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "game_room_id", null: false
    t.text "content", null: false
    t.string "media_url"
    t.jsonb "answers", default: {}, null: false
    t.string "correct_answer_key", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id"], name: "index_questions_on_game_room_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "question_id", null: false
    t.string "chosen_key", limit: 1, null: false
    t.float "response_time", null: false
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_responses_on_player_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  add_foreign_key "game_rooms", "companies", column: "companies_id"
  add_foreign_key "houses", "companies", column: "companies_id"
  add_foreign_key "managers", "companies", column: "companies_id"
  add_foreign_key "players", "companies", column: "companies_id"
  add_foreign_key "players", "game_rooms"
  add_foreign_key "players", "houses"
  add_foreign_key "questions", "game_rooms"
  add_foreign_key "responses", "players"
  add_foreign_key "responses", "questions"
end
