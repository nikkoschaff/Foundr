class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :headline
      t.string :about
      t.string :name

      t.timestamps
    end
  end
end
