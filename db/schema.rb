# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080712030831) do

  create_table "items", :force => true do |t|
    t.integer  "user_id",     :limit => 11
    t.integer  "location_id", :limit => 11
    t.string   "title"
    t.text     "body"
    t.text     "rawbody"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.text     "title"
    t.text     "desc"
    t.string   "lat"
    t.string   "long"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "location_id",   :limit => 11
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "title"
    t.text     "desc"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
