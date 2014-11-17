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

ActiveRecord::Schema.define(version: 20141117023303) do

  create_table "games", force: true do |t|
    t.string   "player_order"
    t.integer  "current_bal"
    t.string   "p1_cards"
    t.string   "p2_cards"
    t.string   "p3_cards"
    t.string   "p4_cards"
    t.string   "card1"
    t.string   "card2"
    t.string   "card3"
    t.string   "card4"
    t.string   "card5"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "table_id"
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.integer  "minimum_bet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: true do |t|
    t.integer  "number"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_id"
    t.integer  "table_id"
    t.integer  "game_id"
    t.integer  "user_level"
  end

end
