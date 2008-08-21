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

ActiveRecord::Schema.define(:version => 20080820193354) do

  create_table "items", :force => true do |t|
    t.column "user_id", :integer, :limit => 11
    t.column "location_id", :integer, :limit => 11
    t.column "title", :string
    t.column "body", :text
    t.column "rawbody", :text
    t.column "published", :boolean
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "locations", :force => true do |t|
    t.column "user_id", :integer, :limit => 11
    t.column "title", :text
    t.column "desc", :text
    t.column "lat", :string
    t.column "long", :string
    t.column "address", :string
    t.column "city", :string
    t.column "state", :string
    t.column "zip", :string
    t.column "country", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "oauth_remote_access_tokens", :force => true do |t|
    t.column "oauth_remote_service_provider_id", :integer, :limit => 11
    t.column "user_id", :integer, :limit => 11
    t.column "token_object", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "oauth_remote_service_providers", :force => true do |t|
    t.column "user_id", :integer, :limit => 11
    t.column "name", :string
    t.column "description", :string
    t.column "authenticate_url", :string
    t.column "consumer_key", :string
    t.column "consumer_secret", :string
    t.column "authorize_url", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "users", :force => true do |t|
    t.column "location_id", :integer, :limit => 11
    t.column "login", :string
    t.column "email", :string
    t.column "first_name", :string, :limit => 80
    t.column "last_name", :string, :limit => 80
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "title", :string
    t.column "desc", :text
    t.column "gravatar", :string
    t.column "remember_token", :string
    t.column "remember_token_expires_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

end
