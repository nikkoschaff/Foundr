class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
