class CreateAmbitionsProfiles < ActiveRecord::Migration
  def change
    create_table :ambitions_profiles do |t|
      t.integer :ambition_id
      t.integer :profile_id


      t.timestamps
    end

    add_index :ambitions_profiles, :ambition_id
    add_index :ambitions_profiles, :profile_id
    add_index :ambitions_profiles, [:ambition_id, :profile_id], unique: true
  end
end
