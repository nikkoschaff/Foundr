class AddProfileIdToGeolocations < ActiveRecord::Migration
  def change
    add_column :geolocations, :profile_id, :integer
  end
end
