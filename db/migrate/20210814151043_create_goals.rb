class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.decimal :target_amount
      t.date :target_due_date
      t.decimal :current_amount
      t.date :start_date

      t.timestamps
    end
  end
end
