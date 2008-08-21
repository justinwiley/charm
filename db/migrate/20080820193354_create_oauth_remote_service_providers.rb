class CreateOauthRemoteServiceProviders < ActiveRecord::Migration
  def self.up
    create_table :oauth_remote_service_providers do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :consumer_key
      t.string :consumer_secret
      t.string :authorize_url
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_remote_service_providers
  end
end
