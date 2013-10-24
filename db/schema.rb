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

ActiveRecord::Schema.define(version: 20130923072705) do

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.string   "phone"
    t.string   "email"
    t.integer  "user_id"
    t.boolean  "deliverable"
    t.boolean  "shisha_allow"
    t.boolean  "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",            precision: 16, scale: 13
    t.decimal  "lng",            precision: 16, scale: 13
    t.string   "district"
    t.string   "city"
    t.string   "postcode"
    t.string   "country"
    t.text     "direction"
    t.float    "service_avg",                              default: 0.0
    t.float    "quality_avg",                              default: 0.0
    t.float    "value_avg",                                default: 0.0
    t.float    "rating_avg",                               default: 0.0
    t.decimal  "price",          precision: 10, scale: 0,  default: 0
    t.string   "menu_uid"
    t.string   "menu_name"
    t.boolean  "is_owner"
    t.string   "contact_note"
    t.string   "suggester_name"
    t.string   "website"
    t.text     "halal_status"
    t.string   "short_address"
    t.string   "flag"
  end

end
