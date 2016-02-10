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

ActiveRecord::Schema.define(version: 20160210032234) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks_tags", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "bookmark_id"
  end

  add_index "bookmarks_tags", ["bookmark_id"], name: "index_bookmarks_tags_on_bookmark_id"
  add_index "bookmarks_tags", ["tag_id"], name: "index_bookmarks_tags_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "github_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
