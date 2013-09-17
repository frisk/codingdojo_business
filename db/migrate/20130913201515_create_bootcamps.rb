class CreateBootcamps < ActiveRecord::Migration
  def change
    create_table :bootcamps do |t|
      t.string :title
      t.string :date

      t.timestamps
    end
  end
end
