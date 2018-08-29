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

ActiveRecord::Schema.define(version: 2018_08_29_134522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_events", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_event"
    t.index ["branch_id"], name: "index_branch_events_on_branch_id"
    t.index ["event_id"], name: "index_branch_events_on_event_id"
  end

  create_table "branches", force: :cascade do |t|
    t.bigint "trip_id"
    t.boolean "master"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_branches_on_trip_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.boolean "confirmed", default: false
    t.string "location"
    t.date "date"
    t.integer "duration"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_relationships_on_child_id"
    t.index ["parent_id"], name: "index_relationships_on_parent_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "start_location"
    t.string "end_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.bigint "user_id"
    t.integer "total_price"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "user_trips", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_user_trips_on_trip_id"
    t.index ["user_id"], name: "index_user_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "branch_events", "branches"
  add_foreign_key "branch_events", "events"
  add_foreign_key "branches", "trips"
  add_foreign_key "relationships", "events", column: "child_id"
  add_foreign_key "relationships", "events", column: "parent_id"
  add_foreign_key "trips", "users"
  add_foreign_key "user_trips", "trips"
  add_foreign_key "user_trips", "users"
end
