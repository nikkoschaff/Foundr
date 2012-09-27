class CreateEmploymentStatuses < ActiveRecord::Migration
  def change
    create_table :employment_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
