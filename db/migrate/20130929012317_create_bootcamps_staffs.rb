class CreateBootcampsStaffs < ActiveRecord::Migration
  def change
    create_table :bootcamps_staffs do |t|
      t.references :bootcamp, index: true
      t.references :staff, index: true

      t.timestamps
    end
  end
end
