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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130425053651) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "lend_id"
    t.integer  "return_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lends", :force => true do |t|
    t.string   "status"
    t.integer  "to"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reminders", :force => true do |t|
    t.integer  "frequency"
    t.integer  "return_id"
    t.integer  "sent"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "return_date"
    t.datetime "last_sent"
  end

  create_table "returns", :force => true do |t|
    t.string   "status"
    t.integer  "to"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "perishable_token", :default => "",    :null => false
    t.boolean  "verified",         :default => false
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end