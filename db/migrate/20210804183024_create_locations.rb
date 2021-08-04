class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.decimal :latitude, precision: 8, scale: 2
      t.decimal :longitude, precision: 8, scale: 2
      t.belongs_to :car
      t.datetime :sent_at

      t.timestamps
    end
  end
end
