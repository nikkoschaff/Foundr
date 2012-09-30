class CreateAmbitions < ActiveRecord::Migration
  def change
    create_table :ambitions do |t|
      t.string :name

      t.timestamps
    end
  end
end
