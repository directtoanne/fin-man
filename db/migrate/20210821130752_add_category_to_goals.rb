class AddCategoryToGoals < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :category, :text, default: "Other"
  end
end
