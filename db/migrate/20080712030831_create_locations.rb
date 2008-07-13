class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :user_id
      t.text :title
      t.text :desc
      t.string :lat
      t.string :long
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
