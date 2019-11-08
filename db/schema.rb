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

ActiveRecord::Schema.define(version: 20191108031730) do

  create_table "contracts", force: :cascade do |t|
    t.integer "sharer_id"
    t.integer "joiners_id"
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["joiners_id"], name: "index_contracts_on_joiners_id"
    t.index ["sharer_id"], name: "index_contracts_on_sharer_id"
    t.index [nil, "created_at"], name: "index_contracts_on_sharer_and_created_at"
  end

  create_table "joiners", force: :cascade do |t|
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "matched", default: "", null: false
    t.string "host_email", default: "", null: false
    t.index ["email"], name: "index_joiners_on_email", unique: true
  end

  create_table "sharers", force: :cascade do |t|
    t.integer "user_id"
    t.string "service"
    t.integer "size"
    t.string "account_id"
    t.string "account_password"
    t.string "status"
    t.index ["user_id"], name: "index_sharers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "usertype", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
