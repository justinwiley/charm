class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :location_id
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :title
      t.text :desc
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
