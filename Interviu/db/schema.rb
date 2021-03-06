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

ActiveRecord::Schema.define(version: 20150523081852) do

  create_table "buyers", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "credits",                default: 100
  end

  add_index "buyers", ["email"], name: "index_buyers_on_email", unique: true
  add_index "buyers", ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
  add_index "buyers", ["username"], name: "index_buyers_on_username", unique: true

  create_table "coupons", force: :cascade do |t|
    t.integer  "variant_id"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coupons", ["variant_id"], name: "index_coupons_on_variant_id"

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "variants", force: :cascade do |t|
    t.boolean  "is_active",  default: true
    t.integer  "price",      default: 0
    t.integer  "quantity",   default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "product_id"
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id"

end
