class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :location_id, :integer
      t.column :login, :string
      t.column :email, :string
      t.column :first_name, :string, :limit => 80
      t.column :last_name, :string, :limit => 80
      t.column :crypted_password, :string, :limit => 40
      t.column :salt, :string, :limit => 40
      t.column :title, :string
      t.column :desc, :text
      t.column :gravatar, :string
      t.column :remember_token, :string
      t.column :remember_token_expires_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
