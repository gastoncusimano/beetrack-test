class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :licence_plate

      t.timestamps
    end
  end
end
