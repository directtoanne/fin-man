class AddCompletedToGoals < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :completed, :bool, default: false
  end
end
