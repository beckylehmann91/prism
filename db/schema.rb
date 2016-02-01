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

ActiveRecord::Schema.define(version: 20160201161742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "height"
    t.integer  "width"
    t.string   "filename"
    t.integer  "lum"
    t.integer  "con"
    t.integer  "var"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sound_tags", force: :cascade do |t|
    t.integer  "sound_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sound_tags", ["image_id"], name: "index_sound_tags_on_image_id", using: :btree
  add_index "sound_tags", ["sound_id"], name: "index_sound_tags_on_sound_id", using: :btree

  create_table "sounds", force: :cascade do |t|
    t.string   "filename"
    t.integer  "luminence"
    t.integer  "contrast"
    t.integer  "color_dominance"
    t.integer  "color_variety"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "sound_tags", "images"
  add_foreign_key "sound_tags", "sounds"
end
