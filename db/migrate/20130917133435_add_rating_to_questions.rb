class AddRatingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rated, :boolean, :default => 0
  end
end
