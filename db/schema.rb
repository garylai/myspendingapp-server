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

ActiveRecord::Schema.define(version: 20150905101712) do

  create_table "spendings", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,                           null: false
    t.decimal  "value",                         precision: 20, scale: 2, null: false
    t.string   "spending_type",     limit: 255,                          null: false
    t.date     "date_of_spending",                                       null: false
    t.integer  "year_of_spending",  limit: 2,                            null: false
    t.integer  "month_of_spending", limit: 1,                            null: false
    t.integer  "day_of_spending",   limit: 1,                            null: false
    t.string   "user_id",           limit: 255,                          null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.datetime "deleted_at"
  end

  add_index "spendings", ["deleted_at"], name: "index_spendings_on_deleted_at", using: :btree
  add_index "spendings", ["id"], name: "PRIMARY_KEY", unique: true, using: :btree
  add_index "spendings", ["user_id"], name: "index_spendings_on_user_id", using: :btree

  create_table "users", id: false, force: :cascade do |t|
    t.string   "id",              limit: 36,  null: false
    t.string   "name",            limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "hashed_password", limit: 255, null: false
    t.string   "salt",            limit: 255, null: false
    t.datetime "deleted_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["id"], name: "PRIMARY_KEY", unique: true, using: :btree

  add_foreign_key "spendings", "users"
end
