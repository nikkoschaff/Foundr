class AddProfileIdToRole < ActiveRecord::Migration
    def change
        add_column :roles, :profile_id, :integer, :null => true
    end
end
