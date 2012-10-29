class AddRoleIdToProfile < ActiveRecord::Migration
    def change
        add_column :profiles, :role_id, :integer
    end
end
