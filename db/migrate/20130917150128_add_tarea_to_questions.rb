class AddTareaToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :txt_area, :boolean, :default => 0
  end
end
