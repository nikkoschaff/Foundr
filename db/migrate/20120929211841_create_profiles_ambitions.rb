class CreateProfilesAmbitions < ActiveRecord::Migration
  def change
    create_table :profiles_ambitions do |t|
      t.integer :profile_id
      t.integer :ambition_id

      t.timestamps
    end

    add_index :profiles_ambitions, :profile_id
    add_index :profiles_ambitions, :ambition_id
    add_index :profiles_ambitions, [:profile_id, :ambition_id], unique: true
  end
end
