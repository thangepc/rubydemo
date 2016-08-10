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

ActiveRecord::Schema.define(version: 20160810064308) do

  create_table "admins", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          limit: 4
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "object",     limit: 255
    t.string   "typ",        limit: 255
    t.string   "data",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "id_item",    limit: 4
    t.integer  "sort",       limit: 4
  end

  create_table "cart_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "image",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "parent_id",   limit: 4
    t.integer  "sort_order",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "content",    limit: 255
    t.integer  "rate",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "order_id",   limit: 4
    t.integer  "quantity",   limit: 4
    t.float    "price",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "invoice_number", limit: 255
    t.string   "description",    limit: 255
    t.integer  "quantity",       limit: 4
    t.float    "total",          limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "email",          limit: 255
    t.string   "address",        limit: 255
    t.string   "phone",          limit: 255
    t.text     "content",        limit: 65535
    t.string   "status",         limit: 255
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "model",       limit: 255
    t.float    "price",       limit: 24
    t.string   "image",       limit: 255
    t.text     "description", limit: 65535
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "email",            limit: 255
    t.string   "password_digest",  limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",           limit: 4
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
  end

end
