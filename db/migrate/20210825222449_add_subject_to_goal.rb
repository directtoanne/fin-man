class AddSubjectToGoal < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :subject, :string
  end
end
