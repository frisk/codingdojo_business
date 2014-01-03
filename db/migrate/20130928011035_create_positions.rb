class CreatePositions < ActiveRecord::Migration
  def change
  	remove_column :staffs, :position
  	remove_column :staffs, :first_name
  	remove_column :staffs, :last_name
  	remove_column :staffs, :email
    create_table :positions do |t|
      t.string :name

      t.timestamps
    end
    add_column :bootcamps, :group_email, :string
    add_column :staffs, :position_id, :integer
    add_index :staffs, :position_id
    add_column :staffs, :user_id, :integer
    add_index :staffs, :user_id
  end
end
