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

ActiveRecord::Schema.define(version: 20161223100908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "rules"
    t.integer  "bedroom"
    t.integer  "bathroom"
    t.integer  "price"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.date     "availability_start"
    t.date     "availability_end"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.index ["listing_id"], name: "index_locations_on_listing_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "listing_id"
    t.integer "tag_id"
    t.index ["listing_id", "tag_id"], name: "index_taggings_on_listing_id_and_tag_id", using: :btree
    t.index ["listing_id"], name: "index_taggings_on_listing_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_name"], name: "index_tags_on_tag_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.integer  "age"
    t.string   "gender"
    t.index ["age"], name: "index_users_on_age", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["gender"], name: "index_users_on_gender", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
