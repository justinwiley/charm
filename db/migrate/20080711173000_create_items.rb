class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :user_id
      t.integer :location_id
      t.string :title
      t.text :body
      t.text :rawbody
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
