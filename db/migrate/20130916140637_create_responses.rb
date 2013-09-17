class CreateResponses < ActiveRecord::Migration
  def change
    drop_table :responses
    create_table :responses do |t|
      t.integer :term
      t.references :bootcamp, index: true
      t.references :survey, index: true
      t.references :staff, index: true

      t.timestamps
    end
    add_column :answers, :response_id, :integer
    add_index :answers, :response_id
  end
end
