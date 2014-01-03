class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state

      t.timestamps
    end

    add_column :bootcamps, :location_id, :integer
    add_index :bootcamps, :location_id
  end
end
