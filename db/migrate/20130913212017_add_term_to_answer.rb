class AddTermToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :term, :integer
  end
end
