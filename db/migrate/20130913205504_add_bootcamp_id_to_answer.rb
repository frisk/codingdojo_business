class AddBootcampIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :bootcamp_id, :integer
    add_index :answers, :bootcamp_id
  end
end
