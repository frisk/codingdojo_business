class AddShortToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :short_content, :string
  end
end
