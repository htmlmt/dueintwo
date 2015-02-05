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

ActiveRecord::Schema.define(version: 20150201193006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "price"
    t.string   "stripe_card_token"
    t.string   "slug"
  end

  add_index "items", ["slug"], name: "index_items_on_slug", unique: true, using: :btree

  create_table "loans", force: true do |t|
    t.integer  "item_id"
    t.integer  "borrower_id"
    t.integer  "loaner_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "stripe_card_token"
    t.string   "stripe_customer_token"
    t.date     "reserved_start"
    t.date     "reserved_end"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "loan_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loaner_id"
    t.integer  "borrower_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.string   "address"
    t.string   "username"
    t.integer  "rating"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "stripe_customer_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "stripe_recipient_id"
    t.integer  "phone",                 limit: 8
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
