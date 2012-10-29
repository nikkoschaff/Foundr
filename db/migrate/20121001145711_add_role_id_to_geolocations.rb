class AddRoleIdToGeolocations < ActiveRecord::Migration
  def change
    add_column :geolocations, :role_id, :integer
  end
end
