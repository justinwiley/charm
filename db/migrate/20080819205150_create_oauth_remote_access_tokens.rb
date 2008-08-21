class CreateOauthRemoteAccessTokens < ActiveRecord::Migration
  def self.up
    create_table :oauth_remote_access_tokens do |t|
      t.integer :oauth_remote_service_provider_id
      t.integer :user_id
      t.string :token_object
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_remote_access_tokens
  end
end
