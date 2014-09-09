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

ActiveRecord::Schema.define(version: 20140904143552) do

  create_table "keypairs", force: true do |t|
    t.string   "privkey"
    t.string   "pubkey"
    t.string   "address"
    t.boolean  "used"
    t.integer  "wallet_id"
    t.string   "addr_qrcode_svg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keypairs", ["wallet_id"], name: "index_keypairs_on_wallet_id"

  create_table "transactions", force: true do |t|
    t.string   "sender_addr"
    t.string   "status_msg"
    t.boolean  "confirmed"
    t.string   "receiver_addr"
    t.string   "amount"
    t.string   "fee"
    t.string   "label"
    t.integer  "wallet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["wallet_id"], name: "index_transactions_on_wallet_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wallets", force: true do |t|
    t.integer  "user_id"
    t.string   "label"
    t.integer  "keypair_ptr_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id"

end
