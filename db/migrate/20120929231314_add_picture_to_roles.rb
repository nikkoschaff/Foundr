class AddPictureToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :picture, :string
  end
end
