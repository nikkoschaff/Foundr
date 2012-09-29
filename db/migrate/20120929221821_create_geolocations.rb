class CreateGeolocations < ActiveRecord::Migration
  def change
    create_table :geolocations do |t|
      t.float :latitude
      t.float :longitude
      t.float :accuracy
      t.float :altitude
      t.float :altitude_accuracy

      t.timestamps
    end
  end
end
